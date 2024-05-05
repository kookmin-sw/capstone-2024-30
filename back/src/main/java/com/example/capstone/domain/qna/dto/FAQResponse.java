package com.example.capstone.domain.qna.dto;

import jakarta.persistence.Column;

import java.time.LocalDateTime;

public record FAQResponse(
        Long id,
        String title,
        String author,
        String question,
        String answer,
        LocalDateTime createdDate,
        LocalDateTime updatedDate,
        String tag,
        String language
) {
}
