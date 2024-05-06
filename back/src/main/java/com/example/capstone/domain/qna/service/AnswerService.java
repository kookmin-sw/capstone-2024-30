package com.example.capstone.domain.qna.service;

import com.example.capstone.domain.qna.dto.*;
import com.example.capstone.domain.qna.entity.Answer;
import com.example.capstone.domain.qna.entity.Question;
import com.example.capstone.domain.qna.repository.AnswerRepository;
import com.example.capstone.domain.qna.repository.QuestionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class AnswerService {
    private final AnswerRepository answerRepository;
    private final QuestionRepository questionRepository;

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
    public void upLikeCountById(String userId, Long id) {
        Answer answer = answerRepository.findById(id).get();
        answer.upLikeCount();
    }

    @Transactional
    public void downLikeCountById(String userId, Long id) {
        Answer answer = answerRepository.findById(id).get();
        answer.downLikeCount();
    }
}
