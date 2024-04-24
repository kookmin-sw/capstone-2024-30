package com.example.capstone.global.error;

import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.jwt.exception.JwtTokenInvalidException;
import com.example.capstone.global.dto.ErrorResponse;
import com.example.capstone.global.error.exception.BusinessException;
import com.example.capstone.global.error.exception.ErrorCode;
import com.example.capstone.global.error.exception.InvalidValueException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.RedisConnectionFailureException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.nio.file.AccessDeniedException;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {
    /**
     * 지원하지 않은 HTTP method 호출 할 경우 발생합니다.
     */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    protected ResponseEntity<ErrorResponse> handleHttpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException e) {
        log.error("handleHttpRequestMethodNotSupportedException", e);
        final ErrorResponse response = ErrorResponse.of(ErrorCode.METHOD_NOT_ALLOWED);
        return new ResponseEntity<>(response, HttpStatus.METHOD_NOT_ALLOWED);
    }

    @ExceptionHandler(AccessDeniedException.class)
    protected ResponseEntity<ErrorResponse> handleAccessDeniedException(final AccessDeniedException e) {
        log.error("handleAccessDeniedException", e);
        final ErrorResponse response = ErrorResponse.of(ErrorCode.HANDLE_ACCESS_DENIED);
        return new ResponseEntity<>(response, HttpStatus.valueOf(ErrorCode.HANDLE_ACCESS_DENIED.getStatus()));
    }

    /**
     * {@link jakarta.validation.Valid} annotaion에 의해 validation이 실패했을경우
     * Controller 단에서 발생하여 Error가 넘어옵니다.
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleMethodArgumentNotValidException(final MethodArgumentNotValidException e) {
        log.error("handleMethodArgumentNotValidException", e);
        final ErrorResponse response = ErrorResponse.of(ErrorCode.INVALID_INPUT_VALUE);
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * 유효하지 않은 Token일 경우 발생
     * {@link JwtTokenProvider}에서 try catch에 의해 넘어옵니다.
     */
    @ExceptionHandler(JwtTokenInvalidException.class)
    protected ResponseEntity<ErrorResponse> handleJwtTokenInvalidException(final JwtTokenInvalidException e){
        log.error("handleJwtTokenInvalid", e);
        final ErrorCode errorCode = e.getErrorCode();
        final ErrorResponse response = ErrorResponse.of(errorCode);
        return new ResponseEntity<>(response, HttpStatus.valueOf(errorCode.getStatus()));
    }

    @ExceptionHandler(RedisConnectionFailureException.class)
    protected ResponseEntity<ErrorResponse> handleRedisConnectionFailureException(final RedisConnectionFailureException e){
        log.error("handleJwtTokenInvalid", e);
        final ErrorResponse response = ErrorResponse.of(ErrorCode.REDIS_CONNECTION_FAIL);
        return new ResponseEntity<>(response, HttpStatus.valueOf(ErrorCode.REDIS_CONNECTION_FAIL.getStatus()));
    }

    @ExceptionHandler(InvalidValueException.class)
    protected ResponseEntity<ErrorResponse> handleInvalidValueException(final InvalidValueException e){
        log.error("handleInvalidValueException", e);
        log.error(e.getValue());
        final ErrorCode errorCode = e.getErrorCode();
        final ErrorResponse response = ErrorResponse.of(errorCode);
        return new ResponseEntity<>(response, HttpStatus.valueOf(errorCode.getStatus()));
    }

    @ExceptionHandler(BusinessException.class)
    protected ResponseEntity<ErrorResponse> handleBusinessException(final BusinessException e) {
        log.error("handleBusinessException", e);
        final ErrorCode errorCode = e.getErrorCode();
        final ErrorResponse response = ErrorResponse.of(errorCode);
        return new ResponseEntity<>(response, HttpStatus.valueOf(errorCode.getStatus()));
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    protected ResponseEntity<ErrorResponse> handle404(NoHandlerFoundException e){
        return ResponseEntity
                .status(e.getStatusCode())
                .body(ErrorResponse.builder()
                        .status(e.getStatusCode().value())
                        .message(e.getMessage())
                        .build());
    }

    /**
     * 예상치 못한 오류들은 다 이 곳에서 처리됩니다.
     */
    @ExceptionHandler(Exception.class)
    protected ResponseEntity<ErrorResponse> handleUnExpectedException(final Exception e) {
        log.error("handleUnExpectedException", e);
        final ErrorResponse response = ErrorResponse.of(ErrorCode.INTERNAL_SERVER_ERROR);
        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
