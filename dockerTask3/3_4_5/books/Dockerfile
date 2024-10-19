FROM ubuntu:22.04 AS build

RUN apt-get update && apt install -y openjdk-17-jdk && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY .. /app
RUN chmod +x gradlew && ./gradlew build

FROM ubuntu:22.04

RUN apt-get update && apt install -y openjdk-17-jdk && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/
ENV PATH=$PATH:$JAVA_HOME/bin

WORKDIR /app
COPY --from=build /app/build/libs/books-0.1.0-SNAPSHOT.jar /app/books-0.1.0-SNAPSHOT.jar

ENV DEVOPS="Sergey Suhinin"

EXPOSE 8080

ENTRYPOINT ["java","-jar","books-0.1.0-SNAPSHOT.jar"]