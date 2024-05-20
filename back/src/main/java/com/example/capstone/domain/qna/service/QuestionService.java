package com.example.capstone.domain.qna.service;

import com.example.capstone.domain.qna.dto.*;
import com.example.capstone.domain.qna.entity.Question;
import com.example.capstone.domain.qna.exception.QuestionNotFoundException;
import com.example.capstone.domain.qna.repository.AnswerRepository;
import com.example.capstone.domain.qna.repository.QuestionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class QuestionService {
    private final QuestionRepository questionRepository;
    private final AnswerRepository answerRepository;

    public QuestionResponse createQuestion(String userId, QuestionPostRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Question quest = questionRepository.save(Question.builder().title(request.title()).context(request.context())
                .author(request.author()).createdDate(current).updatedDate(current).tag(request.tag())
                .country(request.country()).uuid(userId).build());

        return quest.toDTO();
    }

    public QuestionResponse getQuestion(Long id) {
        Question quest = questionRepository.findById(id).orElseThrow(() ->
            new QuestionNotFoundException(id)
        );
        return quest.toDTO();
    }

    @Transactional
    public void updateQuestion(String userId, QuestionPutRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Question quest = questionRepository.findById(request.id()).orElseThrow(() ->
            new QuestionNotFoundException(request.id())
        );
        if(quest.getUuid().equals(userId)) {
            quest.update(request.title(), request.context(), current);
        }
    }

    public void eraseQuestion(Long id){
        questionRepository.deleteById(id);
    }

    public QuestionSliceResponse getQuestionList(QuestionListRequest request) {
        Pageable page = PageRequest.of(0, 20);
        Long cursorId = request.cursorId();
        if(cursorId == 0) cursorId = null;
        QuestionSliceResponse questionList = questionRepository.getQuestionListByPaging(cursorId, page, request.word(), request.tag());

        return questionList;
    }
}
