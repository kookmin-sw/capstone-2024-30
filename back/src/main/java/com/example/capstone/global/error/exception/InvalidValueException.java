package com.example.capstone.global.error.exception;

import lombok.Getter;

@Getter
public class InvalidValueException extends BusinessException {
    private String value;

    public InvalidValueException(String value, ErrorCode errorCode) {
        super(value, errorCode);
    }
}