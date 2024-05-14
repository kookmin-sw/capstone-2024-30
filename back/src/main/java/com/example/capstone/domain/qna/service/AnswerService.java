package com.example.capstone.domain.qna.service;

import com.example.capstone.domain.qna.dto.*;
import com.example.capstone.domain.qna.entity.Answer;
import com.example.capstone.domain.qna.entity.Question;
import com.example.capstone.domain.qna.exception.AnswerNotFoundException;
import com.example.capstone.domain.qna.exception.QuestionNotFoundException;
import com.example.capstone.domain.qna.repository.AnswerRepository;
import com.example.capstone.domain.qna.repository.QuestionRepository;
import com.querydsl.core.QueryException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class AnswerService {
    private final AnswerRepository answerRepository;
    private final QuestionRepository questionRepository;
    @Autowired
    private RedisTemplate<String, Object> countTemplate;

    public AnswerResponse createAnswer(String userId, AnswerPostRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Question questionId = questionRepository.findById(request.questionId()).orElseThrow(() ->
                new QuestionNotFoundException(request.questionId())
                );
        Answer answer = answerRepository.save(Answer.builder().question(questionId).author(request.author())
                .context(request.context()).createdDate(current).updatedDate(current).likeCount(0L).uuid(userId).build());
        return answer.toDTO();
    }

    public AnswerSliceResponse getAnswerList(Long questionId, Long cursorId, String sortBy, String uuid) {
        Pageable page = PageRequest.of(0, 10);
        if(cursorId == 0) cursorId = null;
        AnswerSliceResponse answerList = answerRepository.getAnswerListByPaging(cursorId, page, questionId, sortBy, uuid);

        return answerList;
    }

    @Transactional
    public void updateAnswer(String userId, AnswerPutRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Answer answer = answerRepository.findById(request.id()).orElseThrow(() ->
                new AnswerNotFoundException(request.id())
        );
        if(answer.getUuid().equals(userId)){
            answer.update(request.context(), current);
        }
    }

    public void eraseAnswer(Long id) {
        answerRepository.deleteById(id);
    }

    @Transactional
    public void increaseLikeCountById(Long id) {
        HashOperations<String, String, Object> hashOperations = countTemplate.opsForHash();
        String key = "starId::" + id.toString();
        String hashKey = "likes";
        if(hashOperations.get(key, hashKey) == null) {
            hashOperations.put(key, hashKey, answerRepository.getLikeCountById(id));
        }
        hashOperations.increment(key, hashKey, 1L);
        System.out.println(hashOperations.get(key, hashKey));
    }

    @Transactional
    public void decreaseLikeCountById(Long id) {
        HashOperations<String, String, Object> hashOperations = countTemplate.opsForHash();
        String key = "starId::" + id.toString();
        String hashKey = "likes";
        if(hashOperations.get(key, hashKey) == null) {
            hashOperations.put(key, hashKey, answerRepository.getLikeCountById(id));
        }
        hashOperations.increment(key, hashKey, -1L);
        System.out.println(hashOperations.get(key, hashKey));
    }

    @Scheduled(fixedDelay = 1000L * 30L)
    @Transactional
    public void updateLikeCount() {
        String hashKey = "likes";
        Set<String> RedisKey = countTemplate.keys("starId*");
        Iterator<String> it = RedisKey.iterator();

        while(it.hasNext() == true) {
            String data = it.next();
            Long answerId = Long.parseLong(data.split("::")[1]);
            if(countTemplate.opsForHash().get(data, hashKey) == null){
                break;
            }
            Long likeCount = Long.parseLong((String.valueOf(countTemplate.opsForHash().get(data, hashKey))));
            answerRepository.findById(answerId).ifPresent(a -> {
                a.updateLikeCount(likeCount);
            });
            countTemplate.opsForHash().delete(data, hashKey);
        }
        System.out.println("likes update complete");
    }
}
