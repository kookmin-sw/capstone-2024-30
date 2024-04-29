package com.example.capstone.domain.qna.repository;

import com.example.capstone.domain.qna.entity.FAQImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FAQImageRepository extends JpaRepository<FAQImage, Long>, FAQImageCustomRepository {
    FAQImage save(FAQImage faqImage);
}
