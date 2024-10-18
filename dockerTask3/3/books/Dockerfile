FROM gradle:8.8-jdk17 AS build

WORKDIR /app
COPY .. /app
RUN chmod +x gradlew
RUN ./gradlew build

# TODO EXTRA 3.1.1 test later
#FROM ubuntu:latest
#
#RUN apt-get update && apt-get install -y wget curl supervisor openjdk-17-jdk ant && apt-get clean  \
#    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/oracle-jdk17-installer
#
#RUN apt-get update && apt-get install -y ca-certificates-java && apt-get clean && update-ca-certificates -f  \
#    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/oracle-jdk17-installer
#
#ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64/
#RUN export JAVA_HOME
#RUN export PATH=$PATH:/usr/lib/jvm/java-17-openjdk-amd64/bin/

#WORKDIR /app
#COPY --from=builder /app/build/libs/books-0.1.0-SNAPSHOT.jar /app/books-0.1.0-SNAPSHOT.jar

FROM openjdk:17 AS runtime
WORKDIR /app
COPY --from=build /app/build/libs/books-0.1.0-SNAPSHOT.jar /app/books-0.1.0-SNAPSHOT.jar

ENTRYPOINT ["java","-jar","books-0.1.0-SNAPSHOT.jar"]