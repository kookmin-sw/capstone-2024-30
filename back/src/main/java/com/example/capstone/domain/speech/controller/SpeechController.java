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

    @GetMapping("/api/speech/test")
    public void test() throws ExecutionException, InterruptedException {
        speechService.pronunciation("북한 중앙방송은 이날 시사논단에서 미국 국무부가 지난 달 말 발표한 인권보고서와 관련해 다른 나라의 인권에 대해 이러쿵 저러쿵 시비질을 하면서 마치 세계 인권재판관이라도 되는 듯이 행세하고 있다고 비난했다.");
    }
}
