package com.example.capstone.domain.qna.dto;

import java.util.List;

public record FAQEntireResponse(
        FAQResponse faqResponse,
        List<String> imgUrl
) {
}
