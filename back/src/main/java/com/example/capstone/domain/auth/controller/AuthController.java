package com.example.capstone.domain.auth.controller;

import com.example.capstone.domain.auth.dto.ReissueRequest;
import com.example.capstone.domain.auth.dto.TokenResponse;
import com.example.capstone.domain.auth.service.AuthService;
import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.global.dto.ApiResult;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/reissue")
    public ResponseEntity<ApiResult<TokenResponse>> reissue(@RequestBody @Valid ReissueRequest reissueRequest) {
        TokenResponse tokenResponse = authService.reissueToken(reissueRequest.refreshToken());
        return ResponseEntity
                .ok(new ApiResult<>("Successfully get token", tokenResponse));
    }

    @PostMapping("/logout")
    public ResponseEntity<ApiResult<String>> logout(@RequestHeader(HttpHeaders.AUTHORIZATION) String accessToken,
                                                    @RequestBody @Valid ReissueRequest reissueRequest) {
        if (StringUtils.hasText(accessToken) && accessToken.startsWith("Bearer ")) {
            accessToken =  accessToken.substring(7);
        }
        jwtTokenProvider.validateToken(reissueRequest.refreshToken());
        authService.logout(accessToken, reissueRequest.refreshToken());

        return ResponseEntity
                .ok(new ApiResult<>("Successfully logout token", "Logout successful"));
    }
}
