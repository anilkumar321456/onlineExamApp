# =========================
# CREATE FILES INSIDE EXISTING FOLDERS
# =========================

Write-Host "Creating files and adding code..."

# LOGIN SERVICE

New-Item -ItemType Directory -Force -Path "login-service/src/main/java/com/exam/login/controller"
New-Item -ItemType Directory -Force -Path "login-service/src/main/resources"

@"
package com.exam.login.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class LoginController {

    @GetMapping("/health")
    public String health() {
        return "Login Service Running";
    }
}
"@ | Set-Content "login-service/src/main/java/com/exam/login/controller/LoginController.java"

@"
server.port=8081
spring.application.name=login-service
"@ | Set-Content "login-service/src/main/resources/application.properties"

# EXAM SERVICE

New-Item -ItemType Directory -Force -Path "exam-service/src/main/java/com/exam/exam/controller"
New-Item -ItemType Directory -Force -Path "exam-service/src/main/resources"

@"
package com.exam.exam.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/exam")
public class ExamController {

    @GetMapping("/health")
    public String health() {
        return "Exam Service Running";
    }
}
"@ | Set-Content "exam-service/src/main/java/com/exam/exam/controller/ExamController.java"

@"
server.port=8082
spring.application.name=exam-service
"@ | Set-Content "exam-service/src/main/resources/application.properties"

# RESULT SERVICE

New-Item -ItemType Directory -Force -Path "result-service/src/main/java/com/exam/result/controller"
New-Item -ItemType Directory -Force -Path "result-service/src/main/resources"

@"
package com.exam.result.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/result")
public class ResultController {

    @GetMapping("/health")
    public String health() {
        return "Result Service Running";
    }
}
"@ | Set-Content "result-service/src/main/java/com/exam/result/controller/ResultController.java"

@"
server.port=8083
spring.application.name=result-service
"@ | Set-Content "result-service/src/main/resources/application.properties"

# DOCKER COMPOSE

@"
version: '3'

services:

  login-service:
    image: login-service
    ports:
      - "8081:8081"

  exam-service:
    image: exam-service
    ports:
      - "8082:8082"

  result-service:
    image: result-service
    ports:
      - "8083:8083"
"@ | Set-Content "docker-compose.yml"

# JENKINSFILE

@"
pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                echo 'Building Application'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying Application'
            }
        }
    }
}
"@ | Set-Content "Jenkinsfile"

# KUBERNETES FILE

@"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: login-service
spec:
  replicas: 2
  selector:
    matchLabels:
      app: login-service
"@ | Set-Content "kubernetes/login-deployment.yaml"

# README

@"
# Online Exam Application

Microservices Architecture Project
"@ | Set-Content "README.md"

# ADD TO GIT

git add .

Write-Host "Files created successfully."