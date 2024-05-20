package com.example.capstone.domain.help.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QHelp is a Querydsl query type for Help
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QHelp extends EntityPathBase<Help> {

    private static final long serialVersionUID = -836844545L;

    public static final QHelp help = new QHelp("help");

    public final StringPath author = createString("author");

    public final StringPath context = createString("context");

    public final StringPath country = createString("country");

    public final DateTimePath<java.time.LocalDateTime> createdDate = createDateTime("createdDate", java.time.LocalDateTime.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final BooleanPath isDone = createBoolean("isDone");

    public final BooleanPath isHelper = createBoolean("isHelper");

    public final StringPath title = createString("title");

    public final DateTimePath<java.time.LocalDateTime> updatedDate = createDateTime("updatedDate", java.time.LocalDateTime.class);

    public final StringPath uuid = createString("uuid");

    public QHelp(String variable) {
        super(Help.class, forVariable(variable));
    }

    public QHelp(Path<? extends Help> path) {
        super(path.getType(), path.getMetadata());
    }

    public QHelp(PathMetadata metadata) {
        super(Help.class, metadata);
    }

}

