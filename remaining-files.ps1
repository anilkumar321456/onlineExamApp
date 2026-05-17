Write-Host "Creating remaining enterprise files..."

# =====================================
# LOGIN SERVICE MAIN CLASS
# =====================================

New-Item -ItemType Directory -Force -Path "login-service/src/main/java/com/exam/login"

@"
package com.exam.login;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class LoginServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(LoginServiceApplication.class, args);
    }
}
"@ | Set-Content "login-service/src/main/java/com/exam/login/LoginServiceApplication.java"

# =====================================
# LOGIN SERVICE POM.XML
# =====================================

@"
<project xmlns="http://maven.apache.org/POM/4.0.0">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.exam</groupId>
    <artifactId>login-service</artifactId>
    <version>1.0</version>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.5</version>
    </parent>

    <dependencies>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

    </dependencies>

</project>
"@ | Set-Content "login-service/pom.xml"

# =====================================
# EXAM SERVICE MAIN CLASS
# =====================================

New-Item -ItemType Directory -Force -Path "exam-service/src/main/java/com/exam/exam"

@"
package com.exam.exam;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ExamServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(ExamServiceApplication.class, args);
    }
}
"@ | Set-Content "exam-service/src/main/java/com/exam/exam/ExamServiceApplication.java"

# =====================================
# EXAM SERVICE POM.XML
# =====================================

@"
<project xmlns="http://maven.apache.org/POM/4.0.0">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.exam</groupId>
    <artifactId>exam-service</artifactId>
    <version>1.0</version>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.5</version>
    </parent>

    <dependencies>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

    </dependencies>

</project>
"@ | Set-Content "exam-service/pom.xml"

# =====================================
# RESULT SERVICE MAIN CLASS
# =====================================

New-Item -ItemType Directory -Force -Path "result-service/src/main/java/com/exam/result"

@"
package com.exam.result;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ResultServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(ResultServiceApplication.class, args);
    }
}
"@ | Set-Content "result-service/src/main/java/com/exam/result/ResultServiceApplication.java"

# =====================================
# RESULT SERVICE POM.XML
# =====================================

@"
<project xmlns="http://maven.apache.org/POM/4.0.0">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.exam</groupId>
    <artifactId>result-service</artifactId>
    <version>1.0</version>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.5</version>
    </parent>

    <dependencies>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

    </dependencies>

</project>
"@ | Set-Content "result-service/pom.xml"

# =====================================
# DOCKERFILES
# =====================================

@"
FROM openjdk:17
COPY target/*.jar app.jar
ENTRYPOINT [\"java\",\"-jar\",\"/app.jar\"]
"@ | Set-Content "login-service/Dockerfile"

Copy-Item "login-service/Dockerfile" "exam-service/Dockerfile"
Copy-Item "login-service/Dockerfile" "result-service/Dockerfile"

# =====================================
# KUBERNETES SERVICE
# =====================================

@"
apiVersion: v1
kind: Service
metadata:
  name: login-service
spec:
  selector:
    app: login-service
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8081
"@ | Set-Content "kubernetes/login-service.yaml"

# =====================================
# GITIGNORE
# =====================================

@"
target/
.idea/
*.iml
*.log
"@ | Set-Content ".gitignore"

# =====================================
# FRONTEND FILES
# =====================================

@"
<!DOCTYPE html>
<html>
<head>
<title>Online Exam App</title>
</head>
<body>

<h1>Online Exam Application</h1>

</body>
</html>
"@ | Set-Content "frontend/index.html"

git add .

Write-Host "All remaining files created successfully."