package com.example.capstone.domain.speech.controller;

import com.example.capstone.domain.speech.service.SpeechService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

@Controller
@RequiredArgsConstructor
public class SpeechController {
    private final SpeechService speechService;

    @GetMapping("/api/speach/test")
    public void test() throws ExecutionException, InterruptedException {
        speechService.pronunciation();
    }
}
