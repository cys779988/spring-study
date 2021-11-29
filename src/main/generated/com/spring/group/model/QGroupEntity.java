package com.spring.group.model;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QGroupEntity is a Querydsl query type for GroupEntity
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QGroupEntity extends EntityPathBase<GroupEntity> {

    private static final long serialVersionUID = -1927198886L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QGroupEntity groupEntity = new QGroupEntity("groupEntity");

    public final com.spring.common.model.QBaseTimeEntity _super = new com.spring.common.model.QBaseTimeEntity(this);

    //inherited
    public final DateTimePath<java.time.LocalDateTime> createdDate = _super.createdDate;

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final com.spring.security.model.QUserEntity member;

    //inherited
    public final DateTimePath<java.time.LocalDateTime> modifiedDate = _super.modifiedDate;

    public final com.spring.security.model.QUserEntity registrant;

    public QGroupEntity(String variable) {
        this(GroupEntity.class, forVariable(variable), INITS);
    }

    public QGroupEntity(Path<? extends GroupEntity> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QGroupEntity(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QGroupEntity(PathMetadata metadata, PathInits inits) {
        this(GroupEntity.class, metadata, inits);
    }

    public QGroupEntity(Class<? extends GroupEntity> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.member = inits.isInitialized("member") ? new com.spring.security.model.QUserEntity(forProperty("member")) : null;
        this.registrant = inits.isInitialized("registrant") ? new com.spring.security.model.QUserEntity(forProperty("registrant")) : null;
    }

}

