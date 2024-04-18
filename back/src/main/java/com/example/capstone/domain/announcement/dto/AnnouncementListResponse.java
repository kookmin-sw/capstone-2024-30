package com.example.capstone.domain.announcement.dto;

import java.time.LocalDate;

public record AnnouncementListResponse(
        Long id,
        String title,
        String type,
        LocalDate writtenDate,
        String department,
        String author
) {
}
