### 기능적 고려 사항

### 성능적 고려 사항

#### 캐싱

유저들이 자주 접근하는 데이터는 캐싱하는 것이 좋다. 
예를 들어서, 공지사항 목록이나 Q&A 목록인 경우, 자주 바뀌지도 않을텐데 유저들이 해당 게시판에 접속할 때마다 매번 RDB에서 목록을 읽어오는 것은 비효율적이다. 
따라서, Redis같은 곳에 캐싱해두고, 똑같은 요청이 들어오면 빠르게 Redis에서 뽑아가도록 구성했다. 
캐싱 전략은 다음과 같다. 

캐싱 전략은 Look Aside와 Write Around 전략의 조합을 택하였다. 
Read 전략은 Look Aside 전략을 활용했다. 우선적으로 Redis에서 읽어오고, cache miss가 발생했을 때만, RDS에서 읽어오고 다시 redis에 저장하는 방식이다. 
Write 전략은 Write Around 전략을 활용했다. 데이터를 쓸 때, Redis에 저장하지 않고, 반드시 RDB에 저장하고 기존 캐시는 무효화하는 전략이다.

실제 캐싱을 적용하기 전과 후의 시간을 측정해보았다.

캐싱 전에는 메서드를 실행하는데 414ms가 걸렸다.

<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcmB6P8%2FbtsHv9UPRkR%2FFhuxs9J6QGfSkd5TIK77W0%2Fimg.png">

하지만 캐싱 후에는 12ms로 단축되었다.

<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FdugCYt%2FbtsHwfUZui3%2FeGa64zkKyhVTc3nbetwWWk%2Fimg.png">

그런데 캐싱된 데이터를 받으면, class 정보에 대한 field가 json에 추가되는 현상이 있어서 추가 보류를 하였다.

<br>

#### 비동기 처리

모든 요청을 동기적으로 처리하는 것은 매우 비효율적이다. 특히, 이미지를 업로드하거나, 번역 API 같은 다른 API에 요청을 보내거나, 크롤링 등은 매우 오래걸리는 작업이다. 이 모든 작업을 동기적으로 처리하면, 성능에 매우 치명적일 것이다. 그래서, 해당 기능들을 사용하는 경우에는 Async를 통한 비동기 처리를 실시하였다.

이 비동기처리를 위해서 Spring에서 ThreadExecutor를 이용한다. 그런데, 기본 Async Executor SimpleAsyncTaskExecutor인데, 이는 비동기 작업마다 새로운 스레드를 생성한다. 이로 인해 리소스 낭비, 성능 저하, 스케일링 문제 등이 발생할 수 있다. 왜냐하면 Thread Pool 방식 Executor가 아니라서 스레드 재사용을 하지 않기 때문이다. 그래서 실행시간이 짧은 많은 량의 Task를 처리할 때 불리하다. 리소스 측면에서는 각 비동기 작업마다 새로운 스레드를 생성하므로, 동시에 많은 비동기 작업이 요청되면 매번 많은 스레드가 생성된다. 따라서 CPU와 메모리 리소스의 사용량이 과도하게 증가하는 문제가 발생할 수 있다. 성능 저하 면에서는 스레드를 생성하고 소멸시키는 데는 많은 시간과 리소스가 소요된다. 각 작업마다 스레드를 생성하면 이런 오버헤드가 계속 발생하게 되고, 전체적인 시스템 성능에 영향을 끼칠 수 있다. 또한, SimpleAsyncTaskExecutor는 스레드 수에 대한 제한이 없다. 따라서 동시에 많은 요청이 들어올 경우 스레드 수가 무한정으로 제어할 수 없는 수준으로 증가할 수 있으며, 이는 곧 OutOfMemoryError 등의 문제를 일으킬 수 있다.

<img src="https://github.com/kookmin-sw/capstone-2024-30/assets/55117706/015fe505-6317-4994-8bcb-29b131bdda8c">

그래서, 위 사진과 같이 Async의 Executor를 ThreadPool방식의 Executor로 설정했다. 이는, 사용할 스레드 풀에 속한 기본 스레드 수인 corepoolsize, corepoolsize가 가득 찬 상태에서 더이상 추가 처리가 불가능 할때, 대기하는 장소 크기인 queuecapacity, 스레드 풀이 확장될 수 있는 스레드의 상한선, 즉 스레드 수의 상한선인 maxpoolsize를 조정하여 ThreadPool방식의 Async Executor를 구성했다.

#### Race Condition 해결

#### N+1 문제

<br>

### 안정성 고려 사항

<br>

#### 사용자 트래픽 제한

#### 사용자 업로드 파일 용량 제한

<br>

### 보안적 고려 사항

<br>

#### 사용자 비밀번호 암호화

#### JWT를 통한 Authentication

#### Token 탈취 상황 예방

#### AccessToken Ban

#### HMAC

#### 환경변수 적용

<br>

### 테스트 고려 사항

#### Test Container

#### Jacoco

#### Apache Jmeter

<br>

### 현실적 제한 및 개선 필요 사항

<br>

#### 검색 기능 개선

현재 게시물 및 공지사항 검색은 제목으로만 검색된다. 하지만, 이보다 제목 + 내용으로 검색이 가능한 것이 더 좋을 것이다. 이를 위해서 SQL Like 연산자로 내용까지 검색이 가능하긴 하나, Like 연산자는 선형 연산자이기 때문에 성능에 매우 치명적이다. 따라서, ElasticSearch를 이용해서 빠르게 검색하는 것이 더 좋을 것이다. ElasticSearch는 분산 검색 및 분석 엔진으로, 대규모 데이터에서 빠른 전체 텍스트 검색을 지원한다. 추후, ElasticSearch를 통해 우리 RDB에 저장된 글들을 역색인하여 거의 실시간에 가깝게 검색하도록 개선할 것이다.

<br>

#### 인스턴스 성능의 한계

<img src="https://github.com/kookmin-sw/capstone-2024-30/assets/55117706/61f41786-00e2-4ae2-b059-9bbe080edc91">

현재 우리서버는 Free Tier를 사용하여 견딜 수 있는 트래픽의 한계가 있는 상황이다. 이를 해결하기 위해서 수직적 확장 또는 수평적 확장을 고려할 수 있다. 현재 Free Tier 성능이 아닌 더 좋은 EC2 인스턴스를 사용하거나, 여러개의 EC2를 만들어 Load Balancing을 적용하여 Scale Out적인 확장을 할 수도 있다. 하지만, 현재는 비용적인 문제로 불가능한 상황이다.

<br>

#### 무중단 배포

현재 우리 서비스는 Git Actions를 이용한 CI/CD를 적용하고 있다. 하지만, 현재 방식은 새 버전으로 서버가 배포될 때 반드시 1~2분정도 서버가 중단될 수 밖에 없다. 이는, 실제 서비스할 때 매우 치명적이다. 따라서, 무중단 배포가 반드시 필요하다.

<br>

<img src="https://github.com/kookmin-sw/capstone-2024-30/assets/55117706/ad083fdb-03d5-4620-b41b-0f47fdad8edc">

<br>

무중단 배포 방식으로는 Rolling, Canary, Blue-Green 배포 방식 등 여러가지 방법이 있지만, 만약 우리가 무중단 배포를 구축한다면 Blue-Green 배포 방식을 적용할 것이다. Blue-Green이란 두 개의 동일한 환경인 "블루"와 "그린"을 사용하여 새로운 버전의 소프트웨어를 배포하고 롤백하는 방식이다. 블루 그린 배포 방식은 가장 많이 쓰이는 무중단 배포 방식이며, 카나리에 비해서 구현도 간단하고, Rolling 방식보다 훨씬 안정적이다. 따라서, 추후 Blue-Green 무중단 배포 환경을 구축할 계획이다.

<br>

#### 로드 밸런싱

서버를 단일로 구성하면, 많은 트래픽이 몰렸을 때 감당하기 힘들 것이다. 따라서, 서버를 여러개 만들고, Load Balacning하는게 좋은 선택지일 것이다. 하지만, 로드 밸런싱을 하기엔 비용적인 문제 때문에 환경 구축이 어렵다. 왜냐하면, 여러개의 EC2를 띄워야되기 때문이다. 그래서, 어쩔 수 없이 단일 서버로 운영하게 되었지만, 추후 사용자가 늘어나면 로드 밸런싱을 적용할 계획이다.

<br>

#### 캐싱

이미지를 받아오는 S3도 캐싱을 무조건 해야한다. 아니면 S3 비용이 굉장히 많아질 것이고 응답시간이 길어진다. 일반적으로 AWS CloudFront같은 CDN 서버를 두는 경우가 많은데, 이 부분은 시간이 부족해서 하지 못했다.


