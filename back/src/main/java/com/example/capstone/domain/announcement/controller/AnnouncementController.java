package com.example.capstone.domain.announcement.controller;

import com.example.capstone.domain.announcement.service.AnnouncementCallerService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/announcement")
@RequiredArgsConstructor
public class AnnouncementController {
    private final AnnouncementCallerService announcementCallerService;
    @PostMapping("/test")
    @Operation(summary = "공지사항 크롤링", description = "강제로 공지사항 크롤링을 시킴 (테스트용)")
    ResponseEntity<?> test(){
        announcementCallerService.crawlingAnnouncement();
        return ResponseEntity
                .ok("");
    }
}
