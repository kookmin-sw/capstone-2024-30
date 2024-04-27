package com.example.capstone.domain.announcement.service;

import com.example.capstone.domain.announcement.exception.AnnouncementNotFoundException;
import com.example.capstone.domain.announcement.dto.AnnouncementListResponse;
import com.example.capstone.domain.announcement.entity.Announcement;
import com.example.capstone.domain.announcement.repository.AnnouncementRepository;
import com.example.capstone.global.error.exception.BusinessException;
import com.example.capstone.global.error.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.example.capstone.global.error.exception.ErrorCode.TEST_KEY_NOT_VALID;

@Slf4j
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class AnnouncementSearchService {
    private final AnnouncementRepository announcementRepository;

    @Value("${test.key}")
    private String testKey;

    public boolean testKeyCheck(String key){
        if(key.equals(testKey)) return true;
        else throw new BusinessException(TEST_KEY_NOT_VALID);
    }

    public Slice<AnnouncementListResponse> getAnnouncementList(Long cursorId, String type, String language) {
        Pageable pageable = PageRequest.of(0, 10);
        if(cursorId == 0) cursorId = null;
        Slice<AnnouncementListResponse> list = announcementRepository
                .getFilteredAnnouncementsWithPaging(cursorId, type, language, pageable);
        return list;
    }

    public Announcement getAnnouncementDetail(Long id){
        Announcement announcement = announcementRepository.findById(id)
                .orElseThrow(() -> new AnnouncementNotFoundException(id));
        return  announcement;
    }
}
