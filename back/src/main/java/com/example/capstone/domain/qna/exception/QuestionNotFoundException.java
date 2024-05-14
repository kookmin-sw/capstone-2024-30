package com.example.capstone.domain.qna.exception;

import com.example.capstone.global.error.exception.EntityNotFoundException;

public class QuestionNotFoundException extends EntityNotFoundException {

    public QuestionNotFoundException(Long id) {
        super(id + " is not found question");
    }
}
