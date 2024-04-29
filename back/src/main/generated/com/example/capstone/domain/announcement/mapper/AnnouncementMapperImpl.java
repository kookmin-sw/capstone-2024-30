package com.example.capstone.domain.announcement.mapper;

import com.example.capstone.domain.announcement.dto.AnnouncementListResponse;
import com.example.capstone.domain.announcement.entity.Announcement;
import java.time.LocalDate;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-04-30T01:59:17+0900",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 17.0.9 (JetBrains s.r.o.)"
)
public class AnnouncementMapperImpl implements AnnouncementMapper {

    @Override
    public AnnouncementListResponse entityToResponse(Announcement announcement) {
        if ( announcement == null ) {
            return null;
        }

        Long id = null;
        String title = null;
        String type = null;
        LocalDate writtenDate = null;
        String department = null;
        String author = null;

        id = announcement.getId();
        title = announcement.getTitle();
        type = announcement.getType();
        writtenDate = announcement.getWrittenDate();
        department = announcement.getDepartment();
        author = announcement.getAuthor();

        AnnouncementListResponse announcementListResponse = new AnnouncementListResponse( id, title, type, writtenDate, department, author );

        return announcementListResponse;
    }
}
