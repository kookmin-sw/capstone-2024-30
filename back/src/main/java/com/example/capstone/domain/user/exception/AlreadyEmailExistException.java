package com.example.capstone.domain.user.exception;

import com.example.capstone.global.error.exception.InvalidValueException;

import static com.example.capstone.global.error.exception.ErrorCode.ALREADY_EMAIL_EXIST;

public class AlreadyEmailExistException extends InvalidValueException {
    public AlreadyEmailExistException(final String email) {
        super(email, ALREADY_EMAIL_EXIST);
    }
}
