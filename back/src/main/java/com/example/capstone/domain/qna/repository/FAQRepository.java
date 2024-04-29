package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.entity.FAQ;
import com.example.capstone.domain.qna.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FAQRepository extends JpaRepository<FAQ, Long>, FAQListRepository {
    FAQ save(FAQ faq);

    Optional<FAQ> findById(Long id);

    void deleteById(Long id);
}
