package com.example.capstone.domain.qna.controller;

import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.qna.dto.QuestionListRequest;
import com.example.capstone.domain.qna.dto.QuestionPostRequest;
import com.example.capstone.domain.qna.dto.QuestionPutRequest;
import com.example.capstone.domain.qna.dto.QuestionResponse;
import com.example.capstone.domain.qna.entity.Question;
import com.example.capstone.domain.qna.service.ImageService;
import com.example.capstone.domain.qna.service.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

import static org.springframework.http.HttpStatus.CREATED;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/question")
public class QuestionController {

    private final QuestionService questionService;
    private final ImageService imageService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/create")
    public ResponseEntity<?> createQuestion(/*@RequestHeader String token,*/ @RequestPart("content") QuestionPostRequest request,
                                                                             @RequestPart("imgUrl") List<MultipartFile> imgList) {
        List<String> urlList = new ArrayList<>();
        String userId = UUID.randomUUID().toString();//jwtTokenProvider.extractUUID(token);
        QuestionResponse quest = questionService.createQuestion(userId, request);
        if(imgList != null){
            urlList = imageService.upload(imgList, quest.id(), false);
        }
        return ResponseEntity.ok(Map.of("content", quest, "imgUrl", urlList));
    }

    @GetMapping("/read")
    public ResponseEntity<?> readQuestion(@RequestParam Long id) {
        QuestionResponse questionResponse = questionService.getQuestion(id);
        List<String> urlList = imageService.getUrlListByQuestionId(id);
        return ResponseEntity.ok(Map.of("content", questionResponse, "imgUrl", urlList));
    }

    @PutMapping("/update")
    public ResponseEntity<?> updateQuestion(/*@RequestHeader String token,*/ @RequestBody QuestionPutRequest request) {
        String userId = UUID.randomUUID().toString();//jwtTokenProvider.extractUUID(token);
        questionService.updateQuestion(userId, request);
        return ResponseEntity.ok(200);
    }

    @DeleteMapping("/erase")
    public ResponseEntity<?> eraseQuestion(@RequestParam Long id) {
        List<String> urlList = imageService.getUrlListByQuestionId(id);
        for(String url : urlList) {
            imageService.deleteImageFromS3(url);
        }
        questionService.eraseQuestion(id);
        imageService.deleteByQuestionId(id);
        return ResponseEntity.ok(200);
    }



}
