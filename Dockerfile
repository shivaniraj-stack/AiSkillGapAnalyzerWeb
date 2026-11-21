# =====================================================================
# Dockerfile for AI Skill Gap Analyzer Web
# Multi-stage build: Maven build -> Tomcat 9 Runtime
# =====================================================================

# Stage 1: Build the WAR artifact
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /build

# Copy build descriptor and source code
COPY pom.xml .
COPY src ./src

# Build the WAR file (skip tests for speed)
RUN mvn clean package -DskipTests

# Stage 2: Runtime container on Apache Tomcat 9 (Servlet 4.0 / Java EE 8)
FROM tomcat:9.0-jdk17-temurin
LABEL maintainer="College Project Submission"

WORKDIR /usr/local/tomcat/webapps/

# Remove default ROOT application to serve app on root context /
RUN rm -rf ROOT

# Copy packaged WAR as ROOT.war
COPY --from=builder /build/target/*.war ./ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
