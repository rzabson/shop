FROM jenkins/jenkins:lts
USER root
RUN apt-get update


FROM maven:3.9.4 AS build
WORKDIR /app

# Copy the pom.xml and the entire src directory from the order-service folder
COPY order-service/pom.xml ./
# Copy the pom.xml to the working directory
COPY order-service/src ./src
# Copy the src directory to the working directory

# Build the application and output logs to check if the JAR is generated
RUN mvn clean package  && ls -l target  # List files in target after build
# Ensure the generated JAR file will be in /app/target/

# Use OpenJDK 17-slim for running the application
FROM openjdk:17-slim
COPY --from=build /app/target/order-1.0-SNAPSHOT.jar /app/order-.jar

# Set the working directory
WORKDIR /app

# Command to run the application
CMD ["java", "-jar", "order.jar"]