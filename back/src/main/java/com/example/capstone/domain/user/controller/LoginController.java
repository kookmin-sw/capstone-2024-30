package com.example.capstone.domain.user.controller;

import com.example.capstone.domain.user.dto.SigninRequest;
import com.example.capstone.domain.auth.dto.TokenResponse;
import com.example.capstone.domain.user.dto.SignupRequest;
import com.example.capstone.domain.user.service.LoginService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class LoginController {
    private final LoginService loginService;

    @PostMapping("/signup")
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<?> signup(@RequestBody @Valid SignupRequest signupRequest) {
        //TODO : HMAC을 통한 검증 로직 추가 필요
        loginService.signUp(signupRequest);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body("Successfully Signup");
    }

    @PostMapping("/signin")
    public ResponseEntity<TokenResponse> signin(@RequestBody @Valid SigninRequest signinRequest) {
        //TODO : HMAC을 통한 검증 로직 추가 필요
        TokenResponse response = loginService.signIn(signinRequest);
        return ResponseEntity.ok().body(response);
    }
}
