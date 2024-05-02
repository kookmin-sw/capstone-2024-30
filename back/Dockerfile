FROM eclipse-temurin:17-jdk AS download
WORKDIR /workspace/app
RUN wget https://www.openssl.org/source/openssl-1.1.1o.tar.gz

FROM eclipse-temurin:17-jdk AS build
WORKDIR /workspace/app

RUN apt-get update && apt-get remove -y openssl && apt-get install -y perl libfindbin-libs-perl build-essential zlib1g-dev

COPY --from=download /workspace/app/openssl-1.1.1o.tar.gz .
RUN tar -zxvf openssl-1.1.1o.tar.gz

WORKDIR /workspace/app/openssl-1.1.1o
RUN ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
RUN make && make install

RUN apt-get update && apt-get install -y tzdata ca-certificates

COPY . /workspace/app
WORKDIR /workspace/app
RUN chmod +x ./gradlew
RUN --mount=type=cache,target=/root/.gradle ./gradlew clean build
RUN mkdir -p build/dependency && (cd build/dependency; jar -xf ../libs/*-SNAPSHOT.jar)

FROM eclipse-temurin:17-jdk
VOLUME /tmp

COPY --from=build /usr/local/ssl /usr/local/ssl

ARG DEPENDENCY=/workspace/app/build/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

ENV PATH="/usr/local/ssl/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/ssl/lib:$LD_LIBRARY_PATH"
ENV SSL_CERT_DIR "/etc/ssl/certs"

ENTRYPOINT ["java", "-cp", "app:app/lib/*", "com.example.capstone.CapstoneApplication"]
