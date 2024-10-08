FROM jenkins/jenkins:lts
USER root
RUN apt-get update


FROM maven:3.9.4 AS build
WORKDIR /app

# Copy pom.xml and source files
COPY order-service/pom.xml ./
COPY order-service/src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK 23 image to run the application
FROM openjdk:17-slim
COPY --from=build /app/target/order-service-1.0-SNAPSHOT.jar /app/order-service.jar

# Set the working directory
WORKDIR /app

# Command to run the application
CMD ["java", "-jar", "order-service.jar"]