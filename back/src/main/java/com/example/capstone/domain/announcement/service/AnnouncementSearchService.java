package com.example.capstone.domain.announcement.service;

import com.example.capstone.domain.announcement.entity.Announcement;
import com.example.capstone.domain.announcement.repository.AnnouncementRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AnnouncementSearchService {
    private final AnnouncementRepository announcementRepository;

    public List<Announcement> getAnnouncementList(){
        List<Announcement> announcements = announcementRepository.findAll();
        return announcements;
    }
}
