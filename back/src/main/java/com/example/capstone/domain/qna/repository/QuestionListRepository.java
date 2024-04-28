package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.dto.QuestionListResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

import java.util.Map;

public interface QuestionListRepository {
    Map<String, Object> getQuestionListByPaging(Long cursorId, Pageable page, String word, String tag);
}
