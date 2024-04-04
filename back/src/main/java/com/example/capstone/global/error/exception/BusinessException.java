package com.example.capstone.global.error.exception;

import lombok.Getter;

/**
 * 요구사항에 맞지 않을 경우 발생시키는 Exception
 * Service에서 Exception을 발생시켜야 한다면 해당 Exception을 상속하여 사용할 것!!
 */
@Getter
public class BusinessException extends RuntimeException {

    private ErrorCode errorCode;

    public BusinessException(String message, ErrorCode errorCode) {
        super(message);
        this.errorCode = errorCode;
    }

    public BusinessException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }

    @Override
    public synchronized Throwable fillInStackTrace() {
        return this;
    }
}