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


}
