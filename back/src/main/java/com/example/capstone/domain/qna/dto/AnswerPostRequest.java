package com.example.capstone.domain.qna.dto;

public record AnswerPostRequest(
        Long questionId,
        String author,
        String context
) {
}
