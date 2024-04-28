package com.example.capstone.domain.qna.service;

import com.example.capstone.domain.qna.dto.AnswerListResponse;
import com.example.capstone.domain.qna.dto.AnswerPostRequest;
import com.example.capstone.domain.qna.dto.AnswerPutRequest;
import com.example.capstone.domain.qna.dto.AnswerResponse;
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
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AnswerService {
    private final AnswerRepository answerRepository;
    private final QuestionRepository questionRepository;

    public AnswerResponse createAnswer(String userId, AnswerPostRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Question questionId = questionRepository.findById(request.questionId()).get();
        Answer answer = answerRepository.save(Answer.builder().question(questionId).author(request.author())
                .context(request.context()).createdDate(current).updatedDate(current).likeCount(0L).uuid(UUID.fromString(userId)).build());
        return answer.toDTO();
    }

    public Map<String, Object> getAnswerList(Long questionId, Long cursorId, String sortBy) {
        Pageable page = PageRequest.of(0, 10);
        if(cursorId == 0) cursorId = null;
        Map<String, Object> answerList = answerRepository.getAnswerListByPaging(cursorId, page, questionId, sortBy);
        return answerList;
    }

    @Transactional
    public void updateAnswer(String userId, AnswerPutRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Answer answer = answerRepository.findById(request.id()).get();
        answer.update(request.context(), current);
    }



    //TODO 응답 통일
}
