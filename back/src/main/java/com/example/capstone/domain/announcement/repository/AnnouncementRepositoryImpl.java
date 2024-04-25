package com.example.capstone.domain.announcement.repository;

import com.example.capstone.domain.announcement.dto.AnnouncementListResponse;
import com.example.capstone.domain.announcement.entity.Announcement;
import com.example.capstone.domain.announcement.entity.QAnnouncement;
import com.example.capstone.domain.announcement.mapper.AnnouncementMapper;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.stream.Collectors;

import static com.example.capstone.domain.announcement.entity.QAnnouncement.announcement;

@Repository
@RequiredArgsConstructor
public class AnnouncementRepositoryImpl implements AnnouncementCustomRepository {
    private final JPAQueryFactory jpaQueryFactory;

    @Override
    public Slice<AnnouncementListResponse> getFilteredAnnouncementsWithPaging(Long cursorId, String type,
                                                                              String language, Pageable pageable) {
        QAnnouncement announcement = QAnnouncement.announcement;
        BooleanExpression predicate = announcement.isNotNull();
        predicate = predicate.and(eqCursorId(cursorId));
        predicate = predicate.and(announcement.language.eq(language));

        if(!type.equals("all")){
            predicate = predicate.and(announcement.type.eq(type));
        }

        List<Announcement> announcements = jpaQueryFactory
                .selectFrom(announcement)
                .where(predicate)
                .orderBy(announcement.createdDate.desc())
                .limit(pageable.getPageSize() + 1)
                .fetch();

        List<AnnouncementListResponse> list = announcements.stream()
                .map(AnnouncementMapper.INSTANCE::entityToResponse).collect(Collectors.toList());

        boolean hasNext = false;
        if (list.size() > pageable.getPageSize() && list.size() != 0) {
            list.remove(pageable.getPageSize());
            hasNext = true;
        }

        return new SliceImpl<>(list, pageable, hasNext);
    }

    private BooleanExpression eqCursorId(Long cursorId) {
        if (cursorId != null) {
            return announcement.id.lt(cursorId);
        }
        return null;
    }
}
