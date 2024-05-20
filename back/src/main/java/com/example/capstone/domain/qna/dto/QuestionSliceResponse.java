package com.example.capstone.domain.qna.dto;

import java.util.List;
import java.util.Map;

public record QuestionSliceResponse(
        Long lastCursorId,
        Boolean hasNext,
        List<QuestionListResponse> questionList
) {
}
