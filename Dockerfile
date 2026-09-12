# Stage 1: Build the application using Maven & Eclipse Temurin 17
FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /app

# Copy project files and build the jar
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application using lightweight Eclipse Temurin 17 JRE/JDK
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
