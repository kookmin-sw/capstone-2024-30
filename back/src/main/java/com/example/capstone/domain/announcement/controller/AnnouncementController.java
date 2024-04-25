package com.example.capstone.domain.announcement.controller;

import com.example.capstone.domain.announcement.dto.AnnouncementListResponse;
import com.example.capstone.domain.announcement.entity.Announcement;
import com.example.capstone.domain.announcement.service.AnnouncementCallerService;
import com.example.capstone.domain.announcement.service.AnnouncementSearchService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Slice;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/announcement")
@RequiredArgsConstructor
public class AnnouncementController {
    private final AnnouncementCallerService announcementCallerService;
    private final AnnouncementSearchService announcementSearchService;

    @PostMapping("/test")
    @Operation(summary = "공지사항 크롤링", description = "강제로 공지사항 크롤링을 시킴 (테스트용)")
    ResponseEntity<?> test(@RequestParam(value = "key") String key) {
        announcementSearchService.testKeyCheck(key);
        announcementCallerService.crawlingAnnouncement();
        return ResponseEntity
                .ok("");
    }

    @GetMapping("")
    @Operation(summary = "공지사항 받아오기", description = "현재 페이지네이션 구현 안됨. 전부다 줌!!")
    ResponseEntity<Map<String, Object>> getAnnouncementList(
            @RequestParam(defaultValue = "all", value = "type") String type,
            @RequestParam(defaultValue = "KO", value = "language") String language,
            @RequestParam(defaultValue = "0", value = "cursor") long cursor
    ) {
        Slice<AnnouncementListResponse> slice = announcementSearchService.getAnnouncementList(cursor, type, language);

        List<AnnouncementListResponse> announcements = slice.getContent();
        boolean hasNext = slice.hasNext();

        Map<String, Object> response = new HashMap<>();
        response.put("announcements", announcements);
        response.put("hasNext", hasNext);

        if(hasNext && !announcements.isEmpty()){
            AnnouncementListResponse lastAnnouncement = announcements.get(announcements.size() - 1);
            response.put("lastCursorId", lastAnnouncement.id());
        }

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{announcementId}")
    ResponseEntity<Announcement> getAnnouncementDetail(@PathVariable(value = "announcementId") long announcementId) {
        Announcement announcement = announcementSearchService.getAnnouncementDetail(announcementId);
        return ResponseEntity
                .ok(announcement);
    }

}
