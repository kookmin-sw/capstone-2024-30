package com.example.capstone.domain.announcement.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QAnnouncement is a Querydsl query type for Announcement
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QAnnouncement extends EntityPathBase<Announcement> {

    private static final long serialVersionUID = -666090741L;

    public static final QAnnouncement announcement = new QAnnouncement("announcement");

    public final com.example.capstone.global.entity.QBaseTimeEntity _super = new com.example.capstone.global.entity.QBaseTimeEntity(this);

    public final StringPath author = createString("author");

    public final StringPath authorPhone = createString("authorPhone");

    //inherited
    public final DateTimePath<java.time.LocalDateTime> createdDate = _super.createdDate;

    public final StringPath department = createString("department");

    public final StringPath document = createString("document");

    public final ListPath<AnnouncementFile, QAnnouncementFile> files = this.<AnnouncementFile, QAnnouncementFile>createList("files", AnnouncementFile.class, QAnnouncementFile.class, PathInits.DIRECT2);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath language = createString("language");

    //inherited
    public final DateTimePath<java.time.LocalDateTime> modifiedDate = _super.modifiedDate;

    public final StringPath title = createString("title");

    public final StringPath type = createString("type");

    public final StringPath url = createString("url");

    public final DatePath<java.time.LocalDate> writtenDate = createDate("writtenDate", java.time.LocalDate.class);

    public QAnnouncement(String variable) {
        super(Announcement.class, forVariable(variable));
    }

    public QAnnouncement(Path<? extends Announcement> path) {
        super(path.getType(), path.getMetadata());
    }

    public QAnnouncement(PathMetadata metadata) {
        super(Announcement.class, metadata);
    }

}

