package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.dto.FAQListResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

import java.util.Map;

public interface FAQListRepository {
    Map<String, Object> getFAQListByPaging(Long cursorId, Pageable page, String language, String word, String tag);
}
