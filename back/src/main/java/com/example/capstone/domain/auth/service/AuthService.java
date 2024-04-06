package com.example.capstone.domain.auth.service;

import com.example.capstone.domain.auth.dto.TokenResponse;
import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.jwt.PrincipalDetails;
import com.example.capstone.global.error.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.example.capstone.global.error.exception.ErrorCode.NOT_EXIST_REFRESH_TOKEN;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AuthService {
    private final JwtTokenProvider jwtTokenProvider;
    private final RedisTemplate<String, String> redisTemplate;

    public TokenResponse reissueToken(PrincipalDetails principalDetails, String refreshToken) {
        jwtTokenProvider.validateToken(refreshToken);

        String UUID = jwtTokenProvider.extractUUID(refreshToken);

        String redisRefreshToken = redisTemplate.opsForValue().get(UUID);
        if (!redisRefreshToken.equals(refreshToken)) {
            throw new BusinessException(NOT_EXIST_REFRESH_TOKEN);
        }

        TokenResponse tokenResponse = new TokenResponse(
                jwtTokenProvider.createAccessToken(principalDetails),
                jwtTokenProvider.createRefreshToken(principalDetails)
        );

        return tokenResponse;
    }
}
