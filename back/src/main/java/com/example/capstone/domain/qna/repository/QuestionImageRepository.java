package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.entity.QuestionImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionImageRepository extends JpaRepository<QuestionImage, Long>, QuestionImageCustomRepository {
    QuestionImage save(QuestionImage qImage);
}
