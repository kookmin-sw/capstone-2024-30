package com.gateway.backgateway.config;

import com.gateway.backgateway.filter.AuthorizationHeaderFilter;
import com.gateway.backgateway.filter.RequestRateLimitFilter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.filter.ratelimit.RedisRateLimiter;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {
    @Value(("${server.chatbot-url}"))
    private String chatbotUrl;

    @Bean
    public RouteLocator gatewayRoutes(RouteLocatorBuilder builder,
                                      AuthorizationHeaderFilter authFilter,
                                      RequestRateLimitFilter limitFilter) {
        /**
         * 여기에 JWT토큰 및 API Rate Limiter가 필요한 Api Routing을 작성해주세요.
         * Spring Security와 비슷한 느낌으로 해주시면 됩니다.
         */
        return builder.routes()
                .route("chatbot-docs",r -> r.path("/docs", "/openapi.json")
                        .uri(chatbotUrl))
                .route("chatbot",r -> r.path("/api/chatbot/**")
                        .filters(f->f
                                .filter(authFilter.apply(config -> {config.setRequiredRole("role_user");}))
                                .filter(limitFilter.apply(config -> {
                                    config.setRateLimiter(redisRateLimiter());
                                    config.setRouteId("chatbot");
                                }))
                        )
                        .uri(chatbotUrl))
                .route(r -> r.path("/api/chat/**")
                        .filters(f->f
                                .filter(authFilter.apply(config -> {config.setRequiredRole("role_user");}))
                                .filter(limitFilter.apply(config -> {
                                    config.setRateLimiter(redisRateLimiter());
                                    config.setRouteId("chat");
                                })))
                        .uri("http://ruby:3000"))
                .route("nonJwt-spring", r -> r.path("/api/user/signin", "/api/user/test", "/api/user/signup",
                                "/api/announcement/**", "/api/menu/**", "/api/speech/**", "/api/question/read", "/api/question/list",
                                "/api/faq/**", "/api/help/read", "/api/help/list", "/api/auth/**", "/api/swagger-ui/**", "/api/api-docs/**",
                                "/api/auth/logout")
                        .uri("http://spring:8080"))
                .route("spring", r -> r.path("/api/**")
                        .filters(f->f
                                .filter(authFilter.apply(config -> {config.setRequiredRole("role_user");}))
                                .filter(limitFilter.apply(config -> {
                                    config.setRateLimiter(redisRateLimiter());
                                    config.setRouteId("spring");
                                }))
                        )
                        .uri("http://spring:8080"))
                .build();
    }

    //TODO: Custom RedisRateLimiter로 변경 예정
    @Bean
    public RedisRateLimiter redisRateLimiter() {
        // 기본 replenishRate 및 burstCapacity 값을 지정합니다.
        return new RedisRateLimiter(20, 60, 3);
    }
}
