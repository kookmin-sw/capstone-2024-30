package com.example.capstone.domain.speech.controller;

import com.example.capstone.domain.speech.service.SpeechService;
import com.example.capstone.global.dto.ApiResult;
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
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/api/speech")
@RequiredArgsConstructor
public class SpeechController {
    private final SpeechService speechService;

    @PostMapping(value = "/test",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @Operation(summary = "발음평가 매서드", description = "발음평가 음성파일(.wav)과 비교문을 통해 발음평가 결과를 반환합니다.")
    @ApiResponse(responseCode = "200", description = "speech-text로 인식된 텍스트, 전체 텍스트 단위 평가 점수, 단어 종합 평가 점수, 각 단어별 평가 내용이 반환됩니다.")
    public ResponseEntity<ApiResult<String>> uploadSpeech(@RequestPart("file") MultipartFile file, @RequestPart("context") String context)
            throws ExecutionException, InterruptedException, IOException {
        CompletableFuture<String> result = speechService.pronunciation(context, file);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully load score", result.get()));
    }
}
