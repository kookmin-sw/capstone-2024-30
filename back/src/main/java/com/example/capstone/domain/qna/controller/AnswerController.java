package com.example.capstone.domain.qna.controller;

import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.qna.dto.*;
import com.example.capstone.domain.qna.service.AnswerService;
import com.example.capstone.global.dto.ApiResult;
import lombok.RequiredArgsConstructor;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
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
        AnswerResponse answer = answerService.createAnswer(userId, request);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully create answer",answer));
    }

    @GetMapping("/list")
    public ResponseEntity<?> listAnswer(@RequestBody AnswerListRequest request) {
        Map<String, Object> response = answerService.getAnswerList(request.questionId(), request.cursorId(), request.sortBy());
        return ResponseEntity
                .ok(new ApiResult<>("Successfully create answer list", response));
    }

    @PutMapping("/update")
    public ResponseEntity<?> updateAnswer(/*@RequestHeader String token,*/ @RequestBody AnswerPutRequest request) {
        String userId = UUID.randomUUID().toString(); //jwtTokenProvider.extractUUID(token);
        answerService.updateAnswer(userId, request);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully update answer", request.questionId()));
    }

    @DeleteMapping("/erase")
    public ResponseEntity<?> eraseAnswer(@RequestBody Long id) {
        answerService.eraseAnswer(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully delete answer", 200));
    }

    @PutMapping("/like")
    public ResponseEntity<?> upLikeCount(@RequestBody Long id) {
        answerService.upLikeCountById(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully like answer", 200));
    }

    @PutMapping("/unlike")
    public ResponseEntity<?> downLikeCount(@RequestBody Long id) {
        answerService.downLikeCountById(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully unlike answer", 200));
    }
}
