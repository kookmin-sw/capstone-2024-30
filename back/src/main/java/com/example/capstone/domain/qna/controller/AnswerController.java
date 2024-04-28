package com.example.capstone.domain.qna.controller;

import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.qna.dto.AnswerListRequest;
import com.example.capstone.domain.qna.dto.AnswerPostRequest;
import com.example.capstone.domain.qna.dto.AnswerPutRequest;
import com.example.capstone.domain.qna.dto.QuestionPostRequest;
import com.example.capstone.domain.qna.service.AnswerService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/answer")
public class AnswerController {
    private final AnswerService answerService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/create")
    public ResponseEntity<?> createAnswer(/*@RequestHeader String token,*/ @RequestBody AnswerPostRequest request) {
        String userId = UUID.randomUUID().toString(); //jwtTokenProvider.extractUUID(token);
        return ResponseEntity.ok(answerService.createAnswer(userId, request));
    }

    @GetMapping("/list")
    public ResponseEntity<?> listAnswer(@RequestBody AnswerListRequest request) {
        return ResponseEntity.ok(answerService.getAnswerList(request.questionId(), request.cursorId(), request.sortBy()));
    }


}
