package com.example.capstone.global.error;

import com.example.capstone.domain.jwt.JwtAuthenticationFilter;
import com.example.capstone.domain.jwt.exception.JwtTokenInvalidException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.RedisConnectionFailureException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;

import java.io.IOException;

import static com.example.capstone.domain.jwt.JwtAuthenticationFilter.EXCEPTION;

/**
 * Filter에서 발생한 오류는 ControllerAdvice단에서 잡을 수 없습니다.
 * 따라서 JWT Token이 문제가 있어도 ExceptionHandling이 불가능합니다.
 * 그래서 Resolver를 통해서 Handler로 넘겨주는 과정입니다.
 *
 * @link https://velog.io/@dltkdgns3435/%EC%8A%A4%ED%94%84%EB%A7%81%EC%8B%9C%ED%81%90%EB%A6%AC%ED%8B%B0-JWT-%EC%98%88%EC%99%B8%EC%B2%98%EB%A6%AC
 */
@Slf4j
@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private final HandlerExceptionResolver resolver;

    public JwtAuthenticationEntryPoint(@Qualifier("handlerExceptionResolver") HandlerExceptionResolver resolver) {
        this.resolver = resolver;
    }


    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException {
        Exception exception = (Exception) request.getAttribute(EXCEPTION);
        if (exception == null) return;

        if (exception instanceof JwtTokenInvalidException jwtTokenInvalidException) {
            resolver.resolveException(request, response, null, jwtTokenInvalidException);
        } else if (exception instanceof RedisConnectionFailureException redisConnectionFailureException) {
            resolver.resolveException(request, response, null, redisConnectionFailureException);
        } else {
            log.error("{}: {}", exception.getClass(), exception.getMessage());
            resolver.resolveException(request, response, null, exception);
        }
    }
}
