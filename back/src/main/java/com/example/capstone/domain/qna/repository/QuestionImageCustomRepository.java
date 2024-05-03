package com.example.capstone.domain.qna.repository;

import java.util.List;

public interface QuestionImageCustomRepository {
    List<String> findByQuestionId(Long questionId);

    void deleteByQuestionId(Long questionId);
}
