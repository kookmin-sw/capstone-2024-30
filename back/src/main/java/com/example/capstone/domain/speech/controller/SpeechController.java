package com.example.capstone.domain.speech.controller;

import com.example.capstone.domain.speech.service.SpeechService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

@Controller
@RequiredArgsConstructor
public class SpeechController {
    private final SpeechService speechService;

    @PostMapping("/api/speech/test")
    public ResponseEntity<?> uploadSpeech(@RequestPart MultipartFile file, String context) throws ExecutionException, InterruptedException, IOException {
        String result = speechService.pronunciation(context, file);
        return ResponseEntity.ok(result);
    }
}
