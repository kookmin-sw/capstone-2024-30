package com.example.capstone.domain.qna.exception;

import com.example.capstone.global.error.exception.EntityNotFoundException;

public class FAQNotFoundException extends EntityNotFoundException {
    public FAQNotFoundException(Long id) {
        super(id + " is not found faq");
    }
}
