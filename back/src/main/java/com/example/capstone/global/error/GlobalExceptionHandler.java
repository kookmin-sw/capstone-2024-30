package com.example.capstone.global.error;

import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.jwt.exception.JwtTokenInvalidException;
import com.example.capstone.global.dto.ApiResult;
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
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.nio.file.AccessDeniedException;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {
    /**
     * 지원하지 않은 HTTP method 호출 할 경우 발생합니다.
     */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    protected ResponseEntity<ApiResult<?>> handleHttpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException e) {
        log.error("handleHttpRequestMethodNotSupportedException", e);
        final ErrorCode errorCode = ErrorCode.METHOD_NOT_ALLOWED;
        return ResponseEntity
                .status(errorCode.getStatus())
                .body(new ApiResult<>(errorCode));
    }

    @ExceptionHandler(AccessDeniedException.class)
    protected ResponseEntity<ApiResult<?>> handleAccessDeniedException(final AccessDeniedException e) {
        log.error("handleAccessDeniedException", e);
        final ErrorCode errorCode = ErrorCode.HANDLE_ACCESS_DENIED;
        return ResponseEntity
                .status(errorCode.getStatus())
                .body(new ApiResult<>(errorCode));
    }

    /**
     * {@link jakarta.validation.Valid} annotaion에 의해 validation이 실패했을경우
     * Controller 단에서 발생하여 Error가 넘어옵니다.
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiResult<?>> handleMethodArgumentNotValidException(final MethodArgumentNotValidException e) {
        log.error("handleMethodArgumentNotValidException", e);
        final ErrorCode errorCode = ErrorCode.INVALID_JWT_TOKEN;
        return ResponseEntity
                .status(errorCode.getStatus())
                .body(new ApiResult<>(errorCode));
    }

    /**
     * 유효하지 않은 Token일 경우 발생
     * {@link JwtTokenProvider}에서 try catch에 의해 넘어옵니다.
     */
    @ExceptionHandler(JwtTokenInvalidException.class)
    protected ResponseEntity<ApiResult<?>> handleJwtTokenInvalidException(final JwtTokenInvalidException e){
        log.error("handleJwtTokenInvalid", e);
        final ErrorCode errorCode = e.getErrorCode();
        return ResponseEntity
                .status(errorCode.getStatus())
                .body(new ApiResult<>(errorCode));
    }

    /*
    * 업로드 파일 용량이 최대 용량보다 초과시 발생
    * */
    @ExceptionHandler(MultipartException.class)
    @ResponseStatus(HttpStatus.PAYLOAD_TOO_LARGE)
    protected ResponseEntity<ApiResult<?>> handleMaxUploadSizeExceededException (final MultipartException e){
        log.error("handleMaxUploadSizeExceededException", e);
        final ErrorCode errorCode = ErrorCode.MAX_SIZE_UPLOAD_EXCEED;
        return ResponseEntity
                .status(errorCode.getStatus())
                .body(new ApiResult<>(errorCode));
    }

    @ExceptionHandler(RedisConnectionFailureException.class)
    protected ResponseEntity<ApiResult<?>> handleRedisConnectionFailureException(final RedisConnectionFailureException e){
        log.error("handleJwtTokenInvalid", e);
        final ErrorCode erroCode = ErrorCode.REDIS_CONNECTION_FAIL;
        return ResponseEntity
                .status(erroCode.getStatus())
                .body(new ApiResult<>(erroCode));
    }

    @ExceptionHandler(InvalidValueException.class)
    protected ResponseEntity<ApiResult<?>> handleInvalidValueException(final InvalidValueException e){
        log.error("handleInvalidValueException", e);
        log.error(e.getValue());
        final ErrorCode errorCode = e.getErrorCode();
        return ResponseEntity
                .status(errorCode.getStatus())
                .body(new ApiResult<>(errorCode));
    }

    @ExceptionHandler(BusinessException.class)
    protected ResponseEntity<ApiResult<?>> handleBusinessException(final BusinessException e) {
        log.error("handleBusinessException", e);
        final ErrorCode errorCode = e.getErrorCode();
        return ResponseEntity
                .status(errorCode.getStatus())
                .body(new ApiResult<>(errorCode));
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    protected ResponseEntity<ApiResult<?>> handle404(NoHandlerFoundException e){
        return ResponseEntity
                .status(e.getStatusCode().value())
                .body(ApiResult.builder()
                        .success(false)
                        .message(e.getMessage())
                        .build()
                );
    }

    /**
     * 예상치 못한 오류들은 다 이 곳에서 처리됩니다.
     */
    @ExceptionHandler(Exception.class)
    protected ResponseEntity<ApiResult<?>> handleUnExpectedException(final Exception e) {
        log.error("handleUnExpectedException", e);
        final ErrorCode errorCode = ErrorCode.INTERNAL_SERVER_ERROR;
        return ResponseEntity
                .status(errorCode.getStatus())
                .body(new ApiResult<>(errorCode));
    }
}
