package com.gateway.backgateway.filter;

import com.gateway.backgateway.exception.JwtTokenInvalidException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.data.redis.core.ReactiveRedisTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.security.Key;
import java.util.function.Function;

@Slf4j
@Component
public class AuthorizationHeaderFilter extends AbstractGatewayFilterFactory<AuthorizationHeaderFilter.Config> {
    private Key key;
    private final ReactiveRedisTemplate<String, Object> redisTemplate;

    public AuthorizationHeaderFilter(@Value("${jwt.secret.key}") String secret,
                                     ReactiveRedisTemplate<String, Object> redisTemplate) {
        super(Config.class);
        byte[] keyBytes = Decoders.BASE64.decode(secret);
        this.key = Keys.hmacShaKeyFor(keyBytes);
        this.redisTemplate = redisTemplate;
    }

    @Override
    public GatewayFilter apply(Config config) {
        GatewayFilter filter = (exchange, chain) -> {
            String requiredRole = config.getRequiredRole();
            ServerHttpRequest request = exchange.getRequest();

            if (!request.getHeaders().containsKey(HttpHeaders.AUTHORIZATION))
                throw JwtTokenInvalidException.INSTANCE;

            String token = request.getHeaders()
                    .getFirst(HttpHeaders.AUTHORIZATION).replace("Bearer ", "");

            log.info("Authorization Token : {}", token);

            if (!validateToken(token)) {
                throw JwtTokenInvalidException.INSTANCE;
            }

            return isTokenBlacked(token)
                    .flatMap(isBlacked -> {
                        if (isBlacked) {
                            throw JwtTokenInvalidException.INSTANCE;
                        }
                        String userRole = resolveTokenRole(token).replace("[", "").replace("]", "");

                        if (requiredRole.equalsIgnoreCase("role_admin")) {
                            if (!userRole.equalsIgnoreCase("role_admin")) {
                                throw JwtTokenInvalidException.INSTANCE;
                            }
                        } else if (requiredRole.equalsIgnoreCase("role_user")) {
                            if (!userRole.equalsIgnoreCase("role_user")) {
                                throw JwtTokenInvalidException.INSTANCE;
                            }
                        }

                        String uuid = extractUUID(token);
                        addAuthorizationHeaders(request, uuid);
                        return chain.filter(exchange);
                    });
        };

        return filter;
    }

    private Mono<Boolean> isTokenBlacked(String accessToken) {
        return redisTemplate.opsForValue()
                .get(accessToken)
                .map(value -> "logout".equals(value))
                .defaultIfEmpty(false);
    }

    private boolean validateToken(String token) {
        try {
            Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token);
            return true;
        } catch (JwtException e) {
            throw JwtTokenInvalidException.INSTANCE;
        }
    }

    private String resolveTokenRole(String token) {
        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();


            String roles = claims.get("authorities").toString();

            return roles;
        } catch (JwtException e) {
            throw JwtTokenInvalidException.INSTANCE;
        }
    }

    private Claims parseClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    private <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = parseClaims(token);
        return claimsResolver.apply(claims);
    }

    private String extractUUID(String token) {
        return extractClaim(token, claims -> claims.get("uuid", String.class));
    }

    private void addAuthorizationHeaders(ServerHttpRequest request, String userInfo) {
        request.mutate()
                .header("X-User-ID", userInfo)
                .build();
    }

    public static class Config {
        private String requiredRole;

        public String getRequiredRole() {
            return requiredRole;
        }

        public void setRequiredRole(String requiredRole) {
            this.requiredRole = requiredRole;
        }
    }
}
