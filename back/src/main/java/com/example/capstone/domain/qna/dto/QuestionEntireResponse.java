package com.example.capstone.domain.qna.dto;

import java.util.List;

public record QuestionEntireResponse(
        QuestionResponse questionResponse,
        List<String> imgUrl
) {
}
