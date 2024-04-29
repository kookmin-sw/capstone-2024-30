package com.example.capstone.domain.qna.dto;

public record FAQPostRequest(
        String title,
        String author,
        String question,
        String answer,
        String language,
        String tag
) {
}
