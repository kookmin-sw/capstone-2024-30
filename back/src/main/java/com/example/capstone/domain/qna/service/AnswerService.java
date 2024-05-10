package com.example.capstone.domain.qna.service;

import com.example.capstone.domain.qna.dto.*;
import com.example.capstone.domain.qna.entity.Answer;
import com.example.capstone.domain.qna.entity.Question;
import com.example.capstone.domain.qna.repository.AnswerRepository;
import com.example.capstone.domain.qna.repository.QuestionRepository;
import com.example.capstone.domain.star.entity.Star;
import lombok.RequiredArgsConstructor;
import org.redisson.api.RLock;
import org.redisson.api.RMapCache;
import org.redisson.api.RedissonClient;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class AnswerService {
    private final AnswerRepository answerRepository;
    private final QuestionRepository questionRepository;
    private final RMapCache<String, Answer> answerRMapCache;
    private final RedissonClient redissonClient;

    public AnswerResponse createAnswer(String userId, AnswerPostRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Question questionId = questionRepository.findById(request.questionId()).get();
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
        Answer answer = answerRepository.findById(request.id()).get();
        if(answer.getUuid().equals(userId)){
            answer.update(request.context(), current);
        }
    }

    public void eraseAnswer(Long id) {
        answerRepository.deleteById(id);
    }

    @Transactional
    public void increaseLikeCountById(String userId, Long id) {
        final String lockName = "like:lock";
        final RLock lock = redissonClient.getLock(lockName);

        try {
            if(!lock.tryLock(1, 3, TimeUnit.SECONDS)){
                return;
            }
            Answer answer = answerRMapCache.get(String.valueOf(id));
            answer.upLikeCount();
            answerRMapCache.put(String.valueOf(id), answer);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(lock != null && lock.isLocked()) {
                lock.unlock();
            }
        }
    }

    @Transactional
    public void decreaseLikeCountById(String userId, Long id) {
        Answer answer = answerRepository.findById(id).get();
        answer.downLikeCount();
    }
}
