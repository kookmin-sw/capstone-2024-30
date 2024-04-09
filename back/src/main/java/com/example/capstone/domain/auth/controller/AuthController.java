package com.example.capstone.domain.auth.controller;

import com.example.capstone.domain.announcement.AnnouncementService;
import com.example.capstone.domain.auth.dto.ReissueRequest;
import com.example.capstone.domain.auth.dto.TokenResponse;
import com.example.capstone.domain.auth.service.AuthService;
import com.example.capstone.domain.jwt.PrincipalDetails;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final AnnouncementService announcementService;

    @PostMapping("/reissue")
    public ResponseEntity<TokenResponse> reissue(@RequestBody @Valid ReissueRequest reissueRequest) {
        TokenResponse tokenResponse = authService.reissueToken(reissueRequest.refreshToekn());
        return ResponseEntity
                .ok()
                .body(tokenResponse);
    }
}
