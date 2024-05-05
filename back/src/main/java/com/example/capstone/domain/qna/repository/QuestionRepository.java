package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.entity.Question;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long>, QuestionListRepository {

    Question save(Question quest);

    Optional<Question> findById(Long id);

    void deleteById(Long id);
}
