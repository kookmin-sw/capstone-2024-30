package com.example.capstone.domain.qna.dto;

public record QuestionListRequest(
        Long cursorId,
        String word,
        String tag
) {
}
