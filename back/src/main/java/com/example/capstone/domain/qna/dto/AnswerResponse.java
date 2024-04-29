package com.example.capstone.domain.qna.dto;

import com.example.capstone.domain.qna.entity.Question;
import jakarta.persistence.Column;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import java.time.LocalDateTime;
import java.util.UUID;

public record AnswerResponse(
        Long id,
        Question question,
        String author,
        String context,
        Long likeCount,
        LocalDateTime createdDate,
        LocalDateTime updatedDate,
        UUID uuid
) {
}
