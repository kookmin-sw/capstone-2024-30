package com.gateway.backgateway.dto;

import com.gateway.backgateway.exception.ErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@AllArgsConstructor
public class ErrorResponse {
    private boolean success;
    private String code;
    private String message;

    public static ErrorResponse error(ErrorCode errorCode) {
        return new ErrorResponse(false, errorCode.getCode(), errorCode.getMessage());
    }
}
