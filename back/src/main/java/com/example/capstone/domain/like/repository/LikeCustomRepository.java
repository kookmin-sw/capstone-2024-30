package com.example.capstone.domain.like.repository;

import com.example.capstone.domain.like.entity.Like;

import java.util.List;
import java.util.Optional;

public interface LikeCustomRepository {
    Optional<Like> findByAnswerIdAndUuid(Long answerId, String uuid);

    void deleteByAnswerIdAndUuid(Long answerId, String uuid);
}
