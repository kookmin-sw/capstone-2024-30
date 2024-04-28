package com.example.capstone.global.dto;

import com.example.capstone.global.error.exception.ErrorCode;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.google.protobuf.Api;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
@JsonPropertyOrder({"success", "code", "message", "response"})
public class ApiResult<T> {
    private final boolean success;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String message;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String code;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private T response;

    public ApiResult(String message){
        this.success = true;
        this.message = message;
    }

    public ApiResult(String message, T response){
        this.success = true;
        this.message = message;
        this.response = response;
    }

    public ApiResult(ErrorCode error){
        this.success = false;
        this.code = error.getCode();
        this.message = error.getMessage();
    }
}
