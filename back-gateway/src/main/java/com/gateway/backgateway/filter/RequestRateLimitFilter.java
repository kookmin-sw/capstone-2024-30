package com.gateway.backgateway.filter;

import com.gateway.backgateway.exception.TooManyRequestException;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.cloud.gateway.filter.ratelimit.KeyResolver;
import org.springframework.cloud.gateway.filter.ratelimit.RedisRateLimiter;
import org.springframework.cloud.gateway.support.HasRouteId;
import org.springframework.stereotype.Component;

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
        GatewayFilter filter = (exchange, chain) -> {
            KeyResolver keyResolver = getOrDefault(config.keyResolver, defaultKeyResolver);
            RedisRateLimiter rateLimiter = getOrDefault(config.rateLimiter, defaultRateLimiter);
            String routeId = config.getRouteId();

            return keyResolver.resolve(exchange)
                    .flatMap(key -> rateLimiter.isAllowed(routeId, key))
                    .flatMap(rateLimitResponse -> {
                        if (rateLimitResponse.isAllowed()) {
                            return chain.filter(exchange);
                        } else {
                            throw TooManyRequestException.INSTANCE;
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
