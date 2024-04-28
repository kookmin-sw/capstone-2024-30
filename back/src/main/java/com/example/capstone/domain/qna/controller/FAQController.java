package com.example.capstone.domain.qna.controller;

import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.qna.dto.FAQListRequest;
import com.example.capstone.domain.qna.dto.FAQPostRequest;
import com.example.capstone.domain.qna.dto.FAQPutRequest;
import com.example.capstone.domain.qna.dto.FAQResponse;
import com.example.capstone.domain.qna.entity.FAQ;
import com.example.capstone.domain.qna.service.FAQService;
import com.example.capstone.domain.qna.service.ImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.springframework.http.HttpStatus.CREATED;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/faq")
public class FAQController {
    private final FAQService faqService;

    private final ImageService imageService;

    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/create")
    public ResponseEntity<?> createFAQ(@RequestPart FAQPostRequest request,
                                       @RequestPart List<MultipartFile> multipartFileList) {
        List<String> urlList = new ArrayList<>();
        FAQResponse faq = faqService.createFAQ(request);
        if(multipartFileList != null) {
            urlList = imageService.upload(multipartFileList, faq.id(), true);
        }
        return ResponseEntity.ok(Map.of("content", faq, "imgUrl", urlList));
    }

    @GetMapping("/read")
    public ResponseEntity<?> readFAQ(@RequestBody Long id) {
        FAQResponse faqResponse = faqService.getFAQ(id);
        List<String> urlList = imageService.getUrlListByFAQId(id);
        return ResponseEntity.ok(Map.of("content", faqResponse, "imgUrl", urlList));
    }

    @PutMapping("/update")
    public ResponseEntity<?> updateFAQ(@RequestBody FAQPutRequest request) {
        faqService.updateFAQ(request);
        return ResponseEntity.ok(200);
    }


}
