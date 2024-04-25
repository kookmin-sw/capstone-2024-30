package com.example.capstone.domain.qna.controller;

import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.qna.dto.QuestionPostRequest;
import com.example.capstone.domain.qna.service.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

import static org.springframework.http.HttpStatus.CREATED;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/question")
public class QuestionController {

    private final QuestionService questionService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/create")
    public ResponseEntity<?> createQuestion(@RequestHeader String token, @RequestBody QuestionPostRequest postRequest) {
        String userId = jwtTokenProvider.extractUUID(token);
        questionService.createQuestion(userId, postRequest);

        return ResponseEntity.status(CREATED).body(200);
    }

    //TODO 글 불러오기
    @GetMapping("/read")
    public ResponseEntity<?> readQuestion(@RequestBody Long id) {
        return ResponseEntity.ok(questionService.readQuestion(id));
    }

    //TODO 글 수정하기
    @PutMapping("/update")
    public ResponseEntity<?> updateQuestion(@RequestHeader String token, @RequestBody Long id, @RequestBody QuestionPostRequest postRequest) {
        String userId = jwtTokenProvider.extractUUID(token);
        questionService.updateQuestion(userId, id, postRequest);
        return ResponseEntity.ok(200);
    }

    //TODO 글 삭제하기
    @DeleteMapping("/erase")
    public ResponseEntity<?> eraseQuestion(@RequestBody Long id) {
        questionService.eraseQuestion(id);
        return ResponseEntity.ok(200);
    }


    //TODO 글 목록 불러오기
    @GetMapping("/list")
    public ResponseEntity<?> listQuestion(@RequestBody Long cursorId, @RequestBody Long size) {
        return ResponseEntity.ok(200);
    }

}
