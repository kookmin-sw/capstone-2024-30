package com.example.capstone.domain.qna.dto;

public record QuestionPutRequest(
        Long id,
        String title,
        String author,
        String context,
        String tag,
        String country
) {
}
