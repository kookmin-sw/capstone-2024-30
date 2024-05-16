package com.example.capstone.domain.qna.dto;

import java.time.LocalDateTime;

public record AnswerListResponse(
        Long id,
        Long questionId,
        String author,
        String context,
        Long likeCount,
        Boolean likeCheck,
        LocalDateTime createdDate,
        LocalDateTime updatedDate,
        String uuid
) {
}
