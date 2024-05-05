package com.example.capstone.domain.qna.dto;

import java.util.List;

public record AnswerSliceResponse(
        Long lastCursorId,
        Boolean hasNext,
        List<AnswerListResponse> answerList
) {
}
