package com.example.capstone.domain.qna.dto;

import org.springframework.web.bind.annotation.RequestBody;

public record FAQListRequest(
        Long cursorId,
        String language,
        String word,
        String tag
) {
}
