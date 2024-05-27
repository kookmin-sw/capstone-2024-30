package com.gateway.backgateway.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gateway.backgateway.dto.ErrorResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.reactive.error.ErrorWebExceptionHandler;
import org.springframework.core.annotation.Order;
import org.springframework.core.io.buffer.DataBufferFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import static com.gateway.backgateway.exception.ErrorCode.*;

@Slf4j
@Order(-1)
@Component
@RequiredArgsConstructor
public class GlobalExceptionHandler implements ErrorWebExceptionHandler {

    private final ObjectMapper objectMapper;

    @Override
    public Mono<Void> handle(ServerWebExchange exchange, Throwable ex) {
        ServerHttpResponse response = exchange.getResponse();
        ErrorCode errorCode;

        if (response.isCommitted()) {
            return Mono.error(ex);
        }

        log.error("Error: {}, Exception Type: {}", ex.getMessage(), ex.getClass().getName());
        response.getHeaders().setContentType(MediaType.APPLICATION_JSON);
        if (ex instanceof JwtTokenInvalidException) {
            errorCode = INVALID_JWT_TOKEN;
            response.setStatusCode(HttpStatus.valueOf(errorCode.getStatus()));
        }
        else if (ex instanceof TooManyRequestException) {
            errorCode = TOO_MANY_REQUESTS;
            response.setStatusCode(HttpStatus.valueOf(errorCode.getStatus()));
        }
        else if (ex instanceof  BusinessException) {
            errorCode = ((BusinessException) ex).getErrorCode();
            response.setStatusCode(HttpStatus.valueOf(String.valueOf(((BusinessException) ex).getErrorCode())));
        }
        else{
            errorCode = INTERNAL_SERVER_ERROR;
            response.setStatusCode(HttpStatus.valueOf(errorCode.getStatus()));
        }


        return response.writeWith(Mono.fromSupplier(() -> {
            DataBufferFactory bufferFactory = response.bufferFactory();
            try {
                ErrorResponse gwErrorResponse = ErrorResponse.error(errorCode);
                byte[] errorResponse = objectMapper.writeValueAsBytes(gwErrorResponse);

                return bufferFactory.wrap(errorResponse);
            } catch (Exception e) {
                log.error("error", e);
                return bufferFactory.wrap(new byte[0]);
            }
        }));
    }
}
