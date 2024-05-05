package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.entity.QFAQ;
import com.example.capstone.domain.qna.entity.QFAQImage;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class FAQImageRepositoryImpl implements FAQImageCustomRepository{
    private final JPAQueryFactory jpaQueryFactory;

    private final QFAQImage faqImage = QFAQImage.fAQImage;

    private final QFAQ faq = QFAQ.fAQ;

    @Override
    public List<String> findByFAQId(Long faqId) {
        List<String> urlList = jpaQueryFactory
                .select(faqImage.url)
                .from(faqImage)
                .innerJoin(faqImage.faqId, faq)
                .where(faqImage.faqId.id.eq(faqId))
                .distinct()
                .fetch();
        return urlList;
    }

    @Override
    public void deleteByFAQId(Long faqId) {
        jpaQueryFactory
                .delete(faqImage)
                .where(faqImage.faqId.id.eq(faqId))
                .execute();
    }
}
