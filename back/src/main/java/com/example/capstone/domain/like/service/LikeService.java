package com.example.capstone.domain.like.service;

import com.example.capstone.domain.like.entity.Like;
import com.example.capstone.domain.like.repository.LikeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LikeService {
    private final LikeRepository likeRepository;

    @Transactional
    public void likeAnswer(String userId, Long answerId) {
        likeRepository.findByAnswerIdAndUuid(answerId, userId).ifPresentOrElse(
                l -> {
                    l.updateClick(true);
        },      () -> {
                    likeRepository.save(Like.builder().uuid(userId).answerId(answerId).isClick(true).build());
        });
    }

    @Transactional
    public void unlikeAnswer(String userId, Long answerId) {
        likeRepository.findByAnswerIdAndUuid(answerId, userId).ifPresent(
                l -> {
                    l.updateClick(false);
                });
    }

}