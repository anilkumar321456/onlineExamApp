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
