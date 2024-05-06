package com.example.capstone.domain.qna.dto;

import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

public record QuestionListResponse (
        Long id,
        String title,
        String author,
        String context,
        String tag,
        String country,
        Long answerCount,
        LocalDateTime createdDate
) {
}
