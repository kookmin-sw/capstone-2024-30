package com.example.capstone.domain.like.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QLike is a Querydsl query type for Like
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QLike extends EntityPathBase<Like> {

    private static final long serialVersionUID = -1705593941L;

    public static final QLike like = new QLike("like1");

    public final NumberPath<Long> answerId = createNumber("answerId", Long.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final BooleanPath isClick = createBoolean("isClick");

    public final StringPath uuid = createString("uuid");

    public QLike(String variable) {
        super(Like.class, forVariable(variable));
    }

    public QLike(Path<? extends Like> path) {
        super(path.getType(), path.getMetadata());
    }

    public QLike(PathMetadata metadata) {
        super(Like.class, metadata);
    }

}

