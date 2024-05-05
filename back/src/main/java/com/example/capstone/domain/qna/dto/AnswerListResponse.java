package com.example.capstone.domain.qna.dto;

import java.time.LocalDateTime;
import java.util.UUID;

public record AnswerListResponse(
        Long id,
        Long questionId,
        String author,
        String context,
        Long likeCount,
        LocalDateTime createdDate,
        LocalDateTime updatedDate,
        UUID uuid
) {
}
