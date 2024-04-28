package com.example.capstone.domain.qna.dto;

public record AnswerPutRequest(
        Long id,
        Long questionId,
        String author,
        String context
) {
}
