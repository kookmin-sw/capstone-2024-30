package com.example.capstone.domain.auth.exception;

import com.example.capstone.global.error.exception.ErrorCode;
import com.example.capstone.global.error.exception.InvalidValueException;

public class AlreadyEmailExistException extends InvalidValueException {
    public AlreadyEmailExistException(final String email){
        super(email, ErrorCode.ALREADY_EMAIL_EXIST);
    }
}
