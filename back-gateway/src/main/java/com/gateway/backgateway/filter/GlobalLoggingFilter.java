package com.gateway.backgateway.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.core.io.buffer.DataBufferUtils;
import org.springframework.http.server.reactive.ServerHttpRequest;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;

@Slf4j
@Configuration
public class GlobalLoggingFilter {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Bean
    @Order(-1)
    public GlobalFilter preLoggingFilter() {
        return (exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest();

            log.info("Global Filter Start: request id -> {}", request.getId());
            log.info("Request: {} {}", request.getMethod(), request.getURI());

            if(request.getHeaders().containsKey("Authorization")) {
                log.info("Authorization: {}", request.getHeaders().get("Authorization"));
            }

            if(request.getMethod().toString().equals("GET")) {
                return chain.filter(exchange);
            }

            return DataBufferUtils.join(request.getBody())
                    .flatMap(dataBuffer -> {
                        byte[] bodyBytes = new byte[dataBuffer.readableByteCount()];
                        dataBuffer.read(bodyBytes);
                        DataBufferUtils.release(dataBuffer);
                        String bodyString = new String(bodyBytes, StandardCharsets.UTF_8);

                        String jsonBody;
                        try {
                            Object json = objectMapper.readValue(bodyString, Object.class);
                            jsonBody = objectMapper.writeValueAsString(json);
                        } catch (Exception e) {
                            jsonBody = bodyString;
                        }

                        log.info("Request Body: {}", jsonBody);

                        return chain.filter(exchange);
                    });
        };
    }

    @Bean
    @Order(Ordered.LOWEST_PRECEDENCE)
    public GlobalFilter postLoggingFilter() {
        return (exchange, chain) -> chain.filter(exchange).then(Mono.fromRunnable(() -> {
            log.info("Response: {}", exchange.getResponse().getStatusCode());
        }));
    }
}
