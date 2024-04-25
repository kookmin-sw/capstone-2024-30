package com.example.capstone.domain.qna.dto;

import java.time.LocalDateTime;

public record QuestionPostRequest(
        String title,
        String author,
        String context,
        String email
) {
}
