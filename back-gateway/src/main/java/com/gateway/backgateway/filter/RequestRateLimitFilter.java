package com.gateway.backgateway.filter;

import com.gateway.backgateway.config.UserIdKeyResolver;
import com.gateway.backgateway.exception.BusinessException;
import com.gateway.backgateway.exception.ErrorCode;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.cloud.gateway.filter.ratelimit.KeyResolver;
import org.springframework.cloud.gateway.filter.ratelimit.RateLimiter;
import org.springframework.cloud.gateway.filter.ratelimit.RedisRateLimiter;
import org.springframework.cloud.gateway.support.HasRouteId;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import static com.gateway.backgateway.exception.ErrorCode.TOO_MANY_REQUESTS;

@Component
@Slf4j
public class RequestRateLimitFilter extends AbstractGatewayFilterFactory<RequestRateLimitFilter.Config> {

    private final KeyResolver defaultKeyResolver;
    private final RedisRateLimiter defaultRateLimiter;

    public RequestRateLimitFilter(
            KeyResolver defaultKeyResolver,
            RedisRateLimiter redisRateLimiter) {
        super(Config.class);
        this.defaultKeyResolver = defaultKeyResolver;
        this.defaultRateLimiter = redisRateLimiter;
    }

    @Override
    public GatewayFilter apply(Config config) {
        log.info("여기 필터 지나는지 확인 1111");
        GatewayFilter filter = (exchange, chain) -> {
            KeyResolver keyResolver = getOrDefault(config.keyResolver, defaultKeyResolver);
            RedisRateLimiter rateLimiter = getOrDefault(config.rateLimiter, defaultRateLimiter);
            String routeId = config.getRouteId();
            log.info("여기 필터 지나는지 확인 2222222");

            return keyResolver.resolve(exchange)
                    .doOnNext(key -> log.info("Resolved key: {}", key))
                    .flatMap(key -> {
                        log.info("Calling rate limiter with routeId: {} and key: {}", routeId, key);
                        return rateLimiter.isAllowed(routeId, key);
                    })
                    .flatMap(rateLimitResponse -> {
                        log.info("Rate limiter response: {}", rateLimitResponse);
                        log.info("여기 필터 지나는지 확인 2222222");
                        if (rateLimitResponse.isAllowed()) {
                            return chain.filter(exchange);
                        } else {
                            throw new BusinessException(TOO_MANY_REQUESTS);
                        }
                    });
        };

        return filter;
    }

    private <T> T getOrDefault(T configValue, T defaultValue) {
        if (configValue != null) return configValue;
        else return defaultValue;
    }

    @Getter
    @Setter
    public static class Config implements HasRouteId {
        private KeyResolver keyResolver;
        private RedisRateLimiter rateLimiter;
        private String routeId;
    }
}
