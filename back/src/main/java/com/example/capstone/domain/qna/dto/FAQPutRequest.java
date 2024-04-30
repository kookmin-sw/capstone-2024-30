package com.example.capstone.domain.qna.dto;

public record FAQPutRequest(
        Long id,
        String title,
        String author,
        String question,
        String answer,
        String language,
        String tag
) {
}
