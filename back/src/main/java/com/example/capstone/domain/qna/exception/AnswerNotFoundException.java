package com.example.capstone.domain.qna.exception;

import com.example.capstone.global.error.exception.EntityNotFoundException;

public class AnswerNotFoundException extends EntityNotFoundException {
    public AnswerNotFoundException(Long id) {
        super(id + " is not found answer");
    }
}
