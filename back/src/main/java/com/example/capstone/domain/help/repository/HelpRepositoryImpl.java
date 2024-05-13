package com.example.capstone.domain.help.repository;

import com.example.capstone.domain.help.dto.HelpListResponse;
import com.example.capstone.domain.help.dto.HelpSliceResponse;
import com.example.capstone.domain.help.entity.QHelp;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import java.util.List;

@RequiredArgsConstructor
public class HelpRepositoryImpl implements HelpListRepository {
    
    private final JPAQueryFactory jpaQueryFactory;
    private QHelp help = QHelp.help;
    
    @Override
    public HelpSliceResponse getHelpListByPaging(Long cursorId, Pageable page, Boolean isDone, Boolean isHelper, String isMine) {
        List<HelpListResponse> helpList = jpaQueryFactory
                .select(
                        Projections.constructor(
                                HelpListResponse.class,
                                help.id, help.title,
                                help.author, help.country,
                                help.createdDate, help.isDone, help.isHelper
                        )
                )
                .from(help)
                .where(cursorId(cursorId),
                        doneEq(isDone),
                        helperEq(isHelper),
                        mineEq(isMine))
                .orderBy(help.createdDate.desc())
                .limit(page.getPageSize() + 1)
                .fetch();

        boolean hasNext = false;
        if(helpList.size() > page.getPageSize()) {
            helpList.remove(page.getPageSize());
            hasNext = true;
        }

        Long lastCursorId = null;

        if(hasNext && helpList.size() != 0) {
            lastCursorId = helpList.get(helpList.size() - 1).id();
        }

        return new HelpSliceResponse(lastCursorId, hasNext, helpList);
    }

    private BooleanExpression cursorId(Long cursorId) {
        return cursorId == null ? null : help.id.gt(cursorId);
    }

    private  BooleanExpression doneEq(Boolean isDone) {
        return isDone == null ? null : help.isDone.eq(isDone);
    }

    private  BooleanExpression helperEq(Boolean isHelper) {
        return isHelper == null ? null : help.isHelper.eq(isHelper);
    }

    private  BooleanExpression mineEq(String isMine) {
        return StringUtils.hasText(isMine) ? help.uuid.eq(isMine) : null;
    }
}
