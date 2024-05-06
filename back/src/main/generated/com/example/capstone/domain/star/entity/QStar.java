package com.example.capstone.domain.star.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QStar is a Querydsl query type for Star
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QStar extends EntityPathBase<Star> {

    private static final long serialVersionUID = -339599199L;

    public static final QStar star = new QStar("star");

    public final NumberPath<Long> answerId = createNumber("answerId", Long.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath uuid = createString("uuid");

    public QStar(String variable) {
        super(Star.class, forVariable(variable));
    }

    public QStar(Path<? extends Star> path) {
        super(path.getType(), path.getMetadata());
    }

    public QStar(PathMetadata metadata) {
        super(Star.class, metadata);
    }

}

