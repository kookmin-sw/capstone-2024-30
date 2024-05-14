package com.example.capstone.domain.star.repository;

import com.example.capstone.domain.star.entity.Star;

import java.util.List;

public interface StarCustomRepository {
    List<Star> findByAnswerIdAndUuid(Long answerId, String uuid);

    void deleteByAnswerIdAndUuid(Long answerId, String uuid);
}
