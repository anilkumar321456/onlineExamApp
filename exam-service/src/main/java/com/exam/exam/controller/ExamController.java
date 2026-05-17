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
