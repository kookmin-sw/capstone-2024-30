package com.example.capstone.domain.announcement.dto;

import com.example.capstone.domain.announcement.entity.Announcement;

import java.time.LocalDate;

public record AnnouncementListResponse(
        Long id,
        String title,
        String type,
        LocalDate writtenDate,
        String department,
        String author
) {
    public static AnnouncementListResponse from(Announcement announcement) {
        return new AnnouncementListResponse(
                announcement.getId(),
                announcement.getTitle(),
                announcement.getType(),
                announcement.getWrittenDate(),
                announcement.getDepartment(),
                announcement.getAuthor()
        );
    }
}
