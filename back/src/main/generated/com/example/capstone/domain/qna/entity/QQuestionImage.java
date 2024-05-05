package com.example.capstone.domain.qna.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QQuestionImage is a Querydsl query type for QuestionImage
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QQuestionImage extends EntityPathBase<QuestionImage> {

    private static final long serialVersionUID = -1153636204L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QQuestionImage questionImage = new QQuestionImage("questionImage");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final QQuestion questionId;

    public final StringPath url = createString("url");

    public QQuestionImage(String variable) {
        this(QuestionImage.class, forVariable(variable), INITS);
    }

    public QQuestionImage(Path<? extends QuestionImage> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QQuestionImage(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QQuestionImage(PathMetadata metadata, PathInits inits) {
        this(QuestionImage.class, metadata, inits);
    }

    public QQuestionImage(Class<? extends QuestionImage> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.questionId = inits.isInitialized("questionId") ? new QQuestion(forProperty("questionId")) : null;
    }

}

