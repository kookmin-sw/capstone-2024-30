package com.example.capstone.domain.speech.controller;

import com.example.capstone.domain.speech.service.SpeechService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/api/speech")
@RequiredArgsConstructor
public class SpeechController {
    private final SpeechService speechService;

    //TODO : Swagger 설명 작성
    @PostMapping(value = "/test",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @Operation(summary = "발음평가 매서드", description = "머하는 거게요")
    @ApiResponse(responseCode = "200", description = "설명좀 써주세요 뭐 반환하는지")
    public ResponseEntity<?> uploadSpeech(@RequestPart("file") MultipartFile file, @RequestPart("context") String context)
            throws ExecutionException, InterruptedException, IOException {
        String result = speechService.pronunciation(context, file);
        return ResponseEntity.ok(result);
    }
}
