package com.example.capstone.domain.announcement.controller;

import com.example.capstone.domain.announcement.entity.Announcement;
import com.example.capstone.domain.announcement.service.AnnouncementCallerService;
import com.example.capstone.domain.announcement.service.AnnouncementSearchService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/announcement")
@RequiredArgsConstructor
public class AnnouncementController {
    private final AnnouncementCallerService announcementCallerService;
    private final AnnouncementSearchService announcementSearchService;
    @PostMapping("/test")
    @Operation(summary = "공지사항 크롤링", description = "강제로 공지사항 크롤링을 시킴 (테스트용)")
    ResponseEntity<?> test(){
        announcementCallerService.crawlingAnnouncement();
        return ResponseEntity
                .ok("");
    }

    @GetMapping("/")
    @Operation(summary = "공지사항 받아오기", description = "현재 페이지네이션 구현 안됨. 전부다 줌")
    ResponseEntity<List<Announcement>> getAnnouncementList(){
        List<Announcement> announcements = announcementSearchService.getAnnouncementList();
        return ResponseEntity
                .ok(announcements);
    }

}
