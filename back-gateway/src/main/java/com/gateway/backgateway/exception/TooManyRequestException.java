package com.gateway.backgateway.exception;

public class TooManyRequestException extends BusinessException {

    // 자주 발생할 수 있는 Exception이라 싱글톤화 하는게 좋다고 합니다.
    public static final TooManyRequestException INSTANCE = new TooManyRequestException();

    private TooManyRequestException() {
        super(ErrorCode.TOO_MANY_REQUESTS);
    }
}
