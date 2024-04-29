package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.dto.AnswerListResponse;
import com.example.capstone.domain.qna.dto.QuestionListResponse;
import com.example.capstone.domain.qna.entity.QAnswer;
import com.example.capstone.domain.qna.entity.QQuestion;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.util.StringUtils;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
public class AnswerRepositoryImpl implements AnswerListRepository {
    private final JPAQueryFactory jpaQueryFactory;
    private final QAnswer answer = QAnswer.answer;
    private final QQuestion question = QQuestion.question;

    @Override
    public Map<String, Object> getAnswerListByPaging(Long cursorId, Pageable page, Long questionId, String sortBy) {
        OrderSpecifier[] orderSpecifiers = createOrderSpecifier(sortBy);

        List<AnswerListResponse> answerList = jpaQueryFactory
                .select(
                        Projections.constructor(AnswerListResponse.class, answer.id, answer.question.id,
                        answer.author, answer.context,
                        answer.likeCount ,answer.createdDate)
                )
                .from(answer)
                .leftJoin(answer.question, question)
                .fetchJoin()
                .where(cursorId(cursorId),
                        questionEq(questionId))
                .orderBy(orderSpecifiers)
                .limit(page.getPageSize() + 1)
                .distinct()
                .fetch();

        boolean hasNext = false;
        if(answerList.size() > page.getPageSize()) {
            answerList.remove(page.getPageSize());
            hasNext = true;
        }
        Map<String, Object> result = Map.of("list", answerList, "pageable", page, "hasNext", hasNext);
        return result;
    }

    private OrderSpecifier[] createOrderSpecifier(String sortBy) {
        List<OrderSpecifier> orderSpecifierList = new ArrayList<>();

        if(sortBy.equals("date")) {
            orderSpecifierList.add(new OrderSpecifier(Order.DESC, answer.createdDate));
        }
        else if(sortBy.equals("like")) {
            orderSpecifierList.add(new OrderSpecifier(Order.DESC, answer.likeCount));
        }
        return orderSpecifierList.toArray(new OrderSpecifier[orderSpecifierList.size()]);
    }

    private BooleanExpression cursorId(Long cursorId) {
        return cursorId == null ? null : answer.id.gt(cursorId);
    }

    private BooleanExpression questionEq(Long questionId) { return questionId == null ? null : answer.question.id.eq(questionId); }
}
