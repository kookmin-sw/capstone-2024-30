package com.example.capstone.domain.qna.service;

import com.example.capstone.domain.qna.dto.QuestionPostRequest;
import com.example.capstone.domain.qna.entity.Question;
import com.example.capstone.domain.qna.repository.QuestionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class QuestionService {
    public final QuestionRepository questionRepository;

    public void createQuestion(String userId, QuestionPostRequest request) {
        LocalDateTime current = LocalDateTime.now();
        questionRepository.save(Question.builder().title(request.title()).context(request.context())
                .author(request.author()).createdDate(current).updatedDate(current)
                .uuid(UUID.fromString(userId)).build());
    }

    public Question readQuestion(Long id) {
        Question quest = questionRepository.findById(id).get();
        return quest;
    }

    @Transactional
    public void updateQuestion(String userId, Long id, QuestionPostRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Question quest = questionRepository.findById(id).get();
        quest.update(request.title(), request.context(), current);
    }

    public void eraseQuestion(Long id){
        questionRepository.deleteById(id);
    }
}
