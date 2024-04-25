package com.example.capstone.domain.announcement.repository;

import com.example.capstone.domain.announcement.dto.AnnouncementListResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

public interface AnnouncementCustomRepository {
    Slice<AnnouncementListResponse> getFilteredAnnouncementsWithPaging(Long cursorId, String type,
                                                                       String language, Pageable pageable);
}
