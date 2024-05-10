package com.example.capstone.domain.star.service;

import com.example.capstone.domain.star.entity.Star;
import com.example.capstone.domain.star.repository.StarRepository;
import lombok.RequiredArgsConstructor;
import org.redisson.api.RLock;
import org.redisson.api.RMapCache;
import org.redisson.api.RedissonClient;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class StarService {
    private final StarRepository starRepository;
    private final RMapCache<String, Star> starRMapCache;
    private final RedissonClient redissonClient;

    public void createStar(Long answerId, String uuid) {
        starRepository.save(Star.builder().answerId(answerId).uuid(uuid).build());
    }

    public boolean checkStar(Long answerId, String uuid) {
        List<Star> star = starRepository.findByAnswerIdAndUuid(answerId, uuid);
        if(star.size() == 0) return false;
        else return true;
    }

    public void deleteStar(Long answerId, String uuid) {
        starRepository.deleteByAnswerIdAndUuid(answerId, uuid);
    }

}