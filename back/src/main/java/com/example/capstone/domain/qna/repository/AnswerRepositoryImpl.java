package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.dto.AnswerListResponse;
import com.example.capstone.domain.qna.dto.AnswerSliceResponse;
import com.example.capstone.domain.qna.entity.QAnswer;
import com.example.capstone.domain.qna.entity.QQuestion;
import com.example.capstone.domain.like.entity.QLike;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
public class AnswerRepositoryImpl implements AnswerListRepository {
    private final JPAQueryFactory jpaQueryFactory;
    private final QAnswer answer = QAnswer.answer;
    private final QQuestion question = QQuestion.question;
    private final QLike like = QLike.like;

    @Override
    public AnswerSliceResponse getAnswerListByPaging(Long cursorId, Pageable page, Long questionId, String sortBy, String uuid) {
        OrderSpecifier[] orderSpecifiers = createOrderSpecifier(sortBy);

        List<AnswerListResponse> answerList = jpaQueryFactory
                .select(
                        Projections.constructor(AnswerListResponse.class, answer.id, answer.question.id,
                        answer.author, answer.context,
                        answer.likeCount, like.isClick.coalesce(false).as("likeCheck"), answer.createdDate, answer.updatedDate, answer.uuid)
                )
                .from(answer)
                .innerJoin(answer.question, question)
                .leftJoin(like)
                .on(answer.id.eq(like.answerId), like.uuid.eq(uuid))
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

        Long lastCursorId = null;

        if(hasNext && answerList.size() != 0) {
            lastCursorId = answerList.get(answerList.size() - 1).id();
        }

        return new AnswerSliceResponse(lastCursorId, hasNext, answerList);
    }

    @Override
    public Long getLikeCountById(Long id) {
        Long likeCount = jpaQueryFactory
                .select(answer.likeCount)
                .from(answer)
                .where(answer.id.eq(id))
                .fetchOne();

        return likeCount;
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
