package com.example.capstone.domain.qna.repository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class QuestionRepositoryImpl implements QuestionCursorRepository{
    private final JPAQueryFactory jpaQueryFactory;
}
