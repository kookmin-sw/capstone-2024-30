package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.dto.QuestionListResponse;
import com.example.capstone.domain.qna.dto.QuestionSliceResponse;
import com.example.capstone.domain.qna.entity.QAnswer;
import com.example.capstone.domain.qna.entity.QQuestion;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
public class QuestionRepositoryImpl implements QuestionListRepository {
    private final JPAQueryFactory jpaQueryFactory;
    private final QQuestion question = QQuestion.question;
    private final QAnswer answer = QAnswer.answer;

    @Override
    public QuestionSliceResponse getQuestionListByPaging(Long cursorId, Pageable page, String word, String tag) {
        List<QuestionListResponse> questionList = jpaQueryFactory
                .select(
                        Projections.constructor(
                                QuestionListResponse.class,
                                question.id, question.title,
                                question.author, question.context,
                                question.tag, question.country, answer.count(), question.createdDate
                        )
                )
                .from(question)
                .leftJoin(answer)
                .on(question.id.eq(answer.question.id))
                .where(cursorId(cursorId),
                        wordEq(word),
                        tagEq(tag))
                .orderBy(question.createdDate.desc())
                .limit(page.getPageSize() + 1)
                .groupBy(question.id)
                .distinct()
                .fetch();

        boolean hasNext = false;
        if(questionList.size() > page.getPageSize() && questionList.size() != 0) {
            questionList.remove(page.getPageSize());
            hasNext = true;
        }

        Long lastCursorId = null;

        if(hasNext && questionList.size() != 0) {
            lastCursorId = questionList.get(questionList.size() - 1).id();
        }

        return new QuestionSliceResponse(lastCursorId, hasNext, questionList);
    }

    private BooleanExpression cursorId(Long cursorId) {
        return cursorId == null ? null : question.id.gt(cursorId);
    }

    private BooleanExpression wordEq(String word) {
        if(StringUtils.hasText(word)) {
            return question.title.contains(word);
        }
        return null;
    }

    private BooleanExpression tagEq(String tag) {
        if(StringUtils.hasText(tag)) {
            return question.tag.eq(tag);
        }
        return null;
    }

    private BooleanExpression questionIdEq(Long id) {
        return answer.question.id.eq(id);
    }
}