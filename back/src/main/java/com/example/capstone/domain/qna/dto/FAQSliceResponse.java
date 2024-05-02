package com.example.capstone.domain.qna.dto;

import java.util.List;

public record FAQSliceResponse(
        Long lastCursorId,
        Boolean hasNext,
        List<FAQListResponse> faqList
) {
}
