# ==========================================
# FULL ONLINE EXAM MICROSERVICES SETUP
# ==========================================

Write-Host "Creating enterprise microservices project..."

# ==========================================
# CREATE LOGIN SERVICE STRUCTURE
# ==========================================

$loginFolders = @(
"login-service/src/main/java/com/exam/entity",
"login-service/src/main/java/com/exam/repository",
"login-service/src/main/java/com/exam/controller",
"login-service/src/main/resources"
)

foreach ($folder in $loginFolders) {
    New-Item -ItemType Directory -Force -Path $folder
}

# USER ENTITY

@"
package com.exam.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String password;
    private String role;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
"@ | Set-Content "login-service/src/main/java/com/exam/entity/User.java"

# USER REPOSITORY

@"
package com.exam.repository;

import com.exam.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsername(String username);
}
"@ | Set-Content "login-service/src/main/java/com/exam/repository/UserRepository.java"

# AUTH CONTROLLER

@"
package com.exam.controller;

import com.exam.entity.User;
import com.exam.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserRepository repository;

    @PostMapping("/register")
    public User register(@RequestBody User user) {
        return repository.save(user);
    }

    @PostMapping("/login")
    public String login(@RequestBody User user) {

        User dbUser = repository.findByUsername(user.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));

        if(dbUser.getPassword().equals(user.getPassword())) {
            return "JWT-TOKEN-EXAMPLE";
        }

        throw new RuntimeException("Invalid Credentials");
    }
}
"@ | Set-Content "login-service/src/main/java/com/exam/controller/AuthController.java"

# APPLICATION PROPERTIES

@"
server.port=8081

spring.datasource.url=jdbc:mysql://localhost:3306/login_db
spring.datasource.username=root
spring.datasource.password=root

spring.jpa.hibernate.ddl-auto=update
"@ | Set-Content "login-service/src/main/resources/application.properties"

# LOGIN POM.XML

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

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>

        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt</artifactId>
            <version>0.9.1</version>
        </dependency>

        <dependency>
            <groupId>com.mysql</groupId>
            <artifactId>mysql-connector-j</artifactId>
            <scope>runtime</scope>
        </dependency>

    </dependencies>

</project>
"@ | Set-Content "login-service/pom.xml"

# ==========================================
# DOCKERFILE
# ==========================================

@"
FROM eclipse-temurin:17

COPY target/*.jar app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
"@ | Set-Content "login-service/Dockerfile"

# ==========================================
# README
# ==========================================

@"
# School Online Exam System

Microservices Architecture Project

Services:
- Login Service
- Exam Service
- Result Service

Technology:
- Spring Boot
- Docker
- Kubernetes
- GitHub Actions
- MySQL
"@ | Set-Content "README.md"

# ==========================================
# GIT ADD
# ==========================================

git add .

Write-Host "======================================="
Write-Host "FULL LOGIN MICROSERVICE CREATED"
Write-Host "======================================="