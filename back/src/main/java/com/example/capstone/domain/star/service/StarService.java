package com.example.capstone.domain.star.service;

import com.example.capstone.domain.star.entity.Star;
import com.example.capstone.domain.star.repository.StarRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class StarService {
    private final StarRepository starRepository;

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