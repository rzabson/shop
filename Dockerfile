FROM jenkins/jenkins:lts
USER root
RUN apt-get update


FROM maven:3.9.4 AS build
WORKDIR /app

# Copy order-service files
COPY order-service/pom.xml order-service/pom.xml
COPY order-service/src order-service/src

# Build order-service
RUN mvn -f order-service/pom.xml clean package

# Copy notification-service files
COPY notification-service/pom.xml notification-service/pom.xml
COPY notification-service/src notification-service/src

# Build notification-service
RUN mvn -f notification-service/pom.xml clean package


# Use OpenJDK 17-slim for running the application
FROM openjdk:17-slim
COPY --from=build /app/order-service/target/order-0.0.1-SNAPSHOT.jar /app/order.jar
COPY --from=build /app/notification-service/target/notification-0.0.1-SNAPSHOT.jar /app/notification.jar

# Set the working directory
WORKDIR /app




