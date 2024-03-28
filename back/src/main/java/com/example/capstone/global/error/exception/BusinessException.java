package com.example.capstone.global.error.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 요구사항에 맞지 않을 경우 발생시키는 Exception
 * Service에서 Exception을 발생시켜야 한다면 해당 Exception을 상속하여 사용할 것!!
 */
@Getter
@AllArgsConstructor
public class BusinessException extends RuntimeException {
    private final ErrorCode errorCode;

    @Override
    public synchronized Throwable fillInStackTrace() {
        return this;
    }
}
