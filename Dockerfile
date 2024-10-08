FROM jenkins/jenkins:lts
USER root
RUN apt-get update


FROM maven:3.9.4-openjdk-23 AS build
WORKDIR /app
COPY ./pom.xml ./
COPY ./src ./src
RUN mvn clean package -DskipTests

# Use a lighter image for running the application
FROM openjdk:23-jre-slim
COPY --from=build /app/target/order-service-1.0-SNAPSHOT.jar /app/order-service.jar
WORKDIR /app
CMD ["java", "-jar", "order-service.jar"]