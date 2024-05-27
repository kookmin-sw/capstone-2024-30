package com.example.capstone.domain.auth.service;

import com.example.capstone.domain.auth.dto.TokenResponse;
import com.example.capstone.domain.jwt.JwtClaim;
import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.jwt.PrincipalDetails;
import com.example.capstone.global.error.exception.BusinessException;
import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.example.capstone.global.error.exception.ErrorCode.INTERNAL_SERVER_ERROR;
import static com.example.capstone.global.error.exception.ErrorCode.NOT_EXIST_REFRESH_TOKEN;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AuthService {
    private final JwtTokenProvider jwtTokenProvider;
    private final RedisTemplate<String, String> redisTemplate;

    public TokenResponse reissueToken(String refreshToken) {
        jwtTokenProvider.validateToken(refreshToken);

        Authentication authentication = jwtTokenProvider.getAuthentication(refreshToken);
        PrincipalDetails principalDetails;

        if (authentication.getPrincipal() instanceof PrincipalDetails) {
            principalDetails = (PrincipalDetails) authentication.getPrincipal();
        } else throw new BusinessException(INTERNAL_SERVER_ERROR);

        String redisRefreshToken = redisTemplate.opsForValue().get(principalDetails.getUuid());
        if (redisRefreshToken == null || !redisRefreshToken.equals(refreshToken)) {
            throw new BusinessException(NOT_EXIST_REFRESH_TOKEN);
        }

        TokenResponse tokenResponse = new TokenResponse(
                jwtTokenProvider.createAccessToken(principalDetails),
                jwtTokenProvider.createRefreshToken(principalDetails)
        );

        return tokenResponse;
    }

    public void logout(String accessToken, String refreshToken) {
        Claims claims = jwtTokenProvider.parseClaims(refreshToken);
        String userId = claims.get(JwtClaim.UUID.getKey(), String.class);
        redisTemplate.opsForValue().getAndDelete(userId);

        redisTemplate.opsForValue().set(accessToken, "logout");
    }
}
