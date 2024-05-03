package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.dto.FAQListResponse;
import com.example.capstone.domain.qna.dto.FAQSliceResponse;
import com.example.capstone.domain.qna.dto.QuestionListResponse;
import com.example.capstone.domain.qna.entity.QFAQ;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
public class FAQRepositoryImpl implements FAQListRepository {
    private final JPAQueryFactory jpaQueryFactory;
    private final QFAQ faq = QFAQ.fAQ;

    @Override
    public FAQSliceResponse getFAQListByPaging(Long cursorId, Pageable page, String language, String word, String tag) {
        List<FAQListResponse> faqList = jpaQueryFactory
                .select(
                        Projections.constructor(
                                FAQListResponse.class ,faq.id, faq.title, faq.author,
                                faq.createdDate, faq.tag, faq.language)
                )
                .from(faq)
                .where(cursorId(cursorId),
                        languageEq(language),
                        wordEq(word),
                        tagEq(tag))
                .orderBy(faq.createdDate.desc())
                .limit(page.getPageSize() + 1)
                .fetch();

        boolean hasNext = false;
        if(faqList.size() > page.getPageSize()) {
            faqList.remove(page.getPageSize());
            hasNext = true;
        }

        Long lastCursorId = null;

        if(hasNext && faqList.size() != 0) {
            lastCursorId = faqList.get(faqList.size() - 1).id();
        }

        return new FAQSliceResponse(lastCursorId, hasNext, faqList);
    }

    private BooleanExpression cursorId(Long cursorId) {
        return cursorId == null ? null : faq.id.gt(cursorId);
    }
    private BooleanExpression languageEq(String language) {
        if(StringUtils.hasText(language)) {
            return faq.language.eq(language);
        }
        return null;
    }
    private BooleanExpression wordEq(String word) {
        if(StringUtils.hasText(word)) {
            return faq.title.contains(word);
        }
        return null;
    }
    private BooleanExpression tagEq(String tag) {
        if(StringUtils.hasText(tag)) {
            return faq.tag.eq(tag);
        }
        return null;
    }
}
