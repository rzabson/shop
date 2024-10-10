FROM jenkins/jenkins:lts
USER root
RUN apt-get update


FROM maven:3.9.4 AS build
WORKDIR /app

COPY order-service/pom.xml ./order-service/pom.xml
COPY order-service/src ./order-service/src
RUN mvn -f order-service/pom.xml clean package

# Copy the src directory to the working directory
COPY notification-service/pom.xml ./notification-service/pom.xml
COPY notification-service/src ./notification-service/src
# Build the application and output logs to check if the JAR is generated
RUN mvn -f notification-service/pom.xml clean package
# Ensure the generated JAR file will be in /app/target/

# Use OpenJDK 17-slim for running the application
FROM openjdk:17-slim
COPY --from=build /app/order-service/target/order-0.0.1-SNAPSHOT.jar /app/order.jar
COPY --from=build /app/notification-service/target/notification-0.0.1-SNAPSHOT.jar /app/notification.jar

# Set the working directory
WORKDIR /app




