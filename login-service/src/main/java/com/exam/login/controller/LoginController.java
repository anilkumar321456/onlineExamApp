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
