package com.example.capstone.domain.like.repository;

import com.example.capstone.domain.like.entity.QLike;
import com.example.capstone.domain.like.entity.Like;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
public class LikeRepositoryImpl implements LikeCustomRepository {
    private final JPAQueryFactory jpaQueryFactory;
    private final QLike like = QLike.like;

    @Override
    public Optional<Like> findByAnswerIdAndUuid(Long answerId, String uuid) {
        return Optional.ofNullable(jpaQueryFactory
                .selectFrom(like)
                .where(like.answerId.eq(answerId),
                        like.uuid.eq(uuid))
                .fetchOne());
    }

    @Override
    public void deleteByAnswerIdAndUuid(Long answerId, String uuid) {
        jpaQueryFactory
                .delete(like)
                .where(like.answerId.eq(answerId),
                        like.uuid.eq(uuid))
                .execute();
    }
}
