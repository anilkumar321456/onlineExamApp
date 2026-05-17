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
