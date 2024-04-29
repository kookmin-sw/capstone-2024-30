FROM eclipse-temurin:17-jdk AS download

WORKDIR /workspace/app

RUN wget http://www.openssl.org/source/openssl-1.1.1.tar.gz

FROM eclipse-temurin:17-jdk AS build
WORKDIR /workspace/app

COPY --from=download /workspace/app/openssl-1.1.1.tar.gz .

RUN apt-get update
RUN apt-get install -y tzdata build-essential ca-certificates libasound2 wget

RUN tar -xzvf openssl-1.1.1.tar.gz \
    && cd openssl-1.1.1 \
    && ./config \
    && make \
    && make install \
    && ldconfig

COPY . /workspace/app

RUN chmod +x ./gradlew
RUN --mount=type=cache,target=/root/.gradle ./gradlew clean bootJar
RUN mkdir -p build/dependency && (cd build/dependency; jar -xf ../libs/*-SNAPSHOT.jar)

FROM eclipse-temurin:17-jdk
VOLUME /tmp
ARG DEPENDENCY=/workspace/app/build/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

ENTRYPOINT ["java","-cp","app:app/lib/*","com.example.capstone.CapstoneApplication"]