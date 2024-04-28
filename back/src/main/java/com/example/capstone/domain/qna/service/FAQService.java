package com.example.capstone.domain.qna.service;

import com.example.capstone.domain.qna.dto.*;
import com.example.capstone.domain.qna.entity.FAQ;
import com.example.capstone.domain.qna.repository.FAQRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class FAQService {
    private final FAQRepository faqRepository;

    public FAQResponse createFAQ(FAQPostRequest request) {
        LocalDateTime current = LocalDateTime.now();
        FAQ faq = faqRepository.save(FAQ.builder().title(request.title()).author(request.author())
                .question(request.question()).answer(request.answer())
                .createdDate(current).updatedDate(current).tag(request.tag()).language(request.language()).build());
        return faq.toDTO();
    }

    public FAQResponse getFAQ(Long id) {
        FAQ faq = faqRepository.findById(id).get();
        return faq.toDTO();
    }

    @Transactional
    public void updateFAQ(FAQPutRequest request) {
        LocalDateTime current = LocalDateTime.now();
        FAQ faq = faqRepository.findById(request.id()).get();
        faq.update(request.title(), request.question(), request.answer(), current);
    }

    public void eraseFAQ(Long id) {
        faqRepository.deleteById(id);
    }



    //TODO 응답 통일
}
