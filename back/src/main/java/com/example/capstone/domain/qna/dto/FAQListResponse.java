package com.example.capstone.domain.qna.dto;

import java.time.LocalDateTime;

public record FAQListResponse(
        Long id,
        String title,
        String author,
        LocalDateTime createdDate,
        String tag,
        String language
) {
}
