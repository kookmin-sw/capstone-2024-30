package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.entity.Answer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AnswerRepository extends JpaRepository<Answer, Long>, AnswerListRepository {
    Answer save(Answer answer);

    Optional<Answer> findById(Long id);

    void deleteById(Long id);
}
