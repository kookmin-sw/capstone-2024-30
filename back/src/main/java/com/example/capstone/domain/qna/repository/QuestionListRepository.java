package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.dto.QuestionListResponse;
import com.example.capstone.domain.qna.dto.QuestionSliceResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

import java.util.Map;

public interface QuestionListRepository {
    QuestionSliceResponse getQuestionListByPaging(Long cursorId, Pageable page, String word, String tag);
}
