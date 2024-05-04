package com.example.capstone.domain.qna.dto;

import java.time.LocalDateTime;
import java.util.UUID;

public record QuestionResponse(
        Long id,
        String title,
        String author,
        String context,
        LocalDateTime createdDate,
        LocalDateTime updatedDate,
        String tag,
        String country,
        UUID uuid
) {
}
