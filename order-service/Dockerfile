# Use an OpenJDK base image
FROM openjdk:17-jdk-slim

RUN mkdir -p /deployments
WORKDIR /deployments

COPY target/order-0.0.1-SNAPSHOT.jar /deployments/application.jar

# Expose the application's port
EXPOSE 9006

ENTRYPOINT ["java", "-jar", "/deployments/application.jar"]
