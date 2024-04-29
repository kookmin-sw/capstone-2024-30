package com.example.capstone.domain.qna.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QFAQImage is a Querydsl query type for FAQImage
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QFAQImage extends EntityPathBase<FAQImage> {

    private static final long serialVersionUID = 1456066822L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QFAQImage fAQImage = new QFAQImage("fAQImage");

    public final QFAQ faqId;

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath url = createString("url");

    public QFAQImage(String variable) {
        this(FAQImage.class, forVariable(variable), INITS);
    }

    public QFAQImage(Path<? extends FAQImage> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QFAQImage(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QFAQImage(PathMetadata metadata, PathInits inits) {
        this(FAQImage.class, metadata, inits);
    }

    public QFAQImage(Class<? extends FAQImage> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.faqId = inits.isInitialized("faqId") ? new QFAQ(forProperty("faqId")) : null;
    }

}

