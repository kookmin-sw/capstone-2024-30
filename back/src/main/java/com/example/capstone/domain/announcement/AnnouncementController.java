package com.example.capstone.domain.announcement;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/announcement")
@RequiredArgsConstructor
public class AnnouncementController {
    private final AnnouncementService announcementService;
    @GetMapping("")
    ResponseEntity<?> test(){
        announcementService.crawlingAnnouncement();
        return ResponseEntity
                .ok("");
    }
}
