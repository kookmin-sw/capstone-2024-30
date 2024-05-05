package com.example.capstone.domain.qna.repository;

import java.util.List;

public interface FAQImageCustomRepository {
    List<String> findByFAQId(Long faqId);
    void deleteByFAQId(Long faqId);
}
