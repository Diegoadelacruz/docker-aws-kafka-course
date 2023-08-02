#### CREACION DEL JAR ####
FROM maven:3-openjdk-17-slim AS builder

WORKDIR /app
COPY ./pom.xml .
RUN mvn -e -B dependency:go-offline
COPY ./src ./src
RUN mvn -e -B -Dmaven.test.skip=true package

#### FASE FINAL DE LA IMAGEN ####
FROM openjdk:17-slim

WORKDIR /workspace

ENV host="mysql_server"
ENV port="3306"
ENV database="demobd"
ENV username="root"
ENV password="12345678"

ARG USER="app"
ARG GROUP="gapp"
ARG USERUID="1000"
ARG GROUPUID="1000"

RUN addgroup --gid $GROUPUID $GROUP
RUN adduser --uid $USERUID --gid $GROUPUID --disabled-password $USER

USER $USER

COPY --from=builder --chown=$USER:$GROUP /app/target/api*.jar app.jar

# COPY --from=builder /app/target/api*.jar app.jar

#no abre ningun puerto, es solo informativo
EXPOSE 8080 
ENTRYPOINT exec java -jar /workspace/app.jar