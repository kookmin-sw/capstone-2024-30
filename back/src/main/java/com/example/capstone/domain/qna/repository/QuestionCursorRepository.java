package com.example.capstone.domain.qna.repository;

import org.springframework.data.domain.Pageable;

public interface QuestionCursorRepository {
    Slice<QuestionSum> findAllByCondition(
            Long cursorId, QuestionReadCondition questionReadCondition, Pageable pageable
    );
}
