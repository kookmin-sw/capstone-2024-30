package com.example.capstone.domain.auth.jwt.exception;

import com.example.capstone.global.error.exception.BusinessException;
import com.example.capstone.global.error.exception.ErrorCode;

public class JwtTokenInvalidException extends BusinessException {

    // 자주 발생할 수 있는 Exception이라 싱글톤화 하는게 좋다고 합니다.
    public static final JwtTokenInvalidException INSTANCE = new JwtTokenInvalidException();

    private JwtTokenInvalidException() {super(ErrorCode.INVALID_JWT_TOKEN);}
}
