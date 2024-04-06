package com.example.capstone.global.error;

import com.example.capstone.global.error.exception.ErrorCode;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ErrorResponse {

    private final int status;
    private final String code;
    private final String message;

    public static ErrorResponse of(final ErrorCode error) {
        return new ErrorResponse(error.getStatus(), error.getCode(), error.getMessage());
    }
}
