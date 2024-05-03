package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.dto.AnswerListResponse;
import com.example.capstone.domain.qna.dto.AnswerSliceResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

import java.util.Map;

public interface AnswerListRepository {
    AnswerSliceResponse getAnswerListByPaging(Long cursorId, Pageable page, Long questionId, String sortBy);
}
