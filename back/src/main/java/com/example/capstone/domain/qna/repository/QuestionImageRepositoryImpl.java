package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.entity.QQuestion;
import com.example.capstone.domain.qna.entity.QQuestionImage;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class QuestionImageRepositoryImpl implements QuestionImageCustomRepository {
    private final JPAQueryFactory jpaQueryFactory;

    private final QQuestionImage questionImage = QQuestionImage.questionImage;

    private final QQuestion question = QQuestion.question;

    @Override
    public List<String> findByQuestionId(Long questionId) {
        List<String> urlList = jpaQueryFactory
                .select(questionImage.url)
                .from(questionImage)
                .leftJoin(questionImage.questionId, question)
                .fetchJoin()
                .where(questionImage.questionId.id.eq(questionId))
                .distinct()
                .fetch();
        return urlList;
    }

    @Override
    public void deleteByQuestionId(Long questionId) {
        jpaQueryFactory
                .delete(questionImage)
                .where(questionImage.questionId.id.eq(questionId))
                .execute();
    }
}
