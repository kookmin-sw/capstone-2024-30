package com.gateway.backgateway.config;

import com.gateway.backgateway.filter.AuthorizationHeaderFilter;
import org.springframework.beans.factory.annotation.Value;
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
                                      AuthorizationHeaderFilter authFilter) {
        return builder.routes()
                .route("chatbot",r -> r.path("/api/chatbot/**")
                        .filters(f->f.filter(authFilter.apply(config -> {config.setRequiredRole("role_user");})))
                        .uri(chatbotUrl))
                .route("chat", r -> r.path("/api/chat/**")
                        .filters(f->f.filter(authFilter.apply(config -> {config.setRequiredRole("role_user");})))
                        .uri("http://ruby:3000"))
                .route("business", r -> r.path("/api/user/signin", "/api/user/test", "/api/user/signup",
                                "/api/announcement/**", "/api/menu/**", "/api/speech"
                                , "/api/auth/**", "/api/swagger-ui/**", "/api/api-docs/**")
                        .uri("http://spring:8080"))
                .route("business", r -> r.path("/api/**")
                        .filters(f->f.filter(authFilter.apply(config -> {config.setRequiredRole("role_user");})))
                        .uri("http://spring:8080"))
                .build();
    }
}
