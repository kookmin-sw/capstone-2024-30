package com.example.capstone.domain.star.repository;

import com.example.capstone.domain.star.entity.QStar;
import com.example.capstone.domain.star.entity.Star;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class StarRepositoryImpl implements StarCustomRepository {
    private final JPAQueryFactory jpaQueryFactory;
    private final QStar star = QStar.star;

    @Override
    public List<Star> findByAnswerIdAndUuid(Long answerId, String uuid) {
        List<Star> stars = jpaQueryFactory
                .selectFrom(star)
                .where(star.answerId.eq(answerId),
                        star.uuid.eq(uuid))
                .fetch();

        return stars;
    }

    @Override
    public void deleteByAnswerIdAndUuid(Long answerId, String uuid) {
        jpaQueryFactory
                .delete(star)
                .where(star.answerId.eq(answerId),
                        star.uuid.eq(uuid))
                .execute();
    }
}
