package com.example.capstone.domain.qna.dto;

import org.springframework.web.bind.annotation.RequestBody;

public record AnswerListRequest(
        Long questionId,
        Long cursorId,
        String sortBy
) {
}
