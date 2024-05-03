package com.example.capstone.domain.announcement.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QAnnouncementFile is a Querydsl query type for AnnouncementFile
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QAnnouncementFile extends EntityPathBase<AnnouncementFile> {

    private static final long serialVersionUID = -2094059737L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QAnnouncementFile announcementFile = new QAnnouncementFile("announcementFile");

    public final QAnnouncement announcement;

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath link = createString("link");

    public final StringPath title = createString("title");

    public QAnnouncementFile(String variable) {
        this(AnnouncementFile.class, forVariable(variable), INITS);
    }

    public QAnnouncementFile(Path<? extends AnnouncementFile> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QAnnouncementFile(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QAnnouncementFile(PathMetadata metadata, PathInits inits) {
        this(AnnouncementFile.class, metadata, inits);
    }

    public QAnnouncementFile(Class<? extends AnnouncementFile> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.announcement = inits.isInitialized("announcement") ? new QAnnouncement(forProperty("announcement")) : null;
    }

}

