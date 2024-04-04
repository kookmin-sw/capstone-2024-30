package com.example.capstone.domain.auth.controller;

import com.example.capstone.domain.auth.dto.SigninRequest;
import com.example.capstone.domain.auth.dto.SignupRequest;
import com.example.capstone.domain.auth.dto.SigninResponse;
import com.example.capstone.domain.auth.service.LoginService;
import com.example.capstone.domain.user.entity.User;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final LoginService loginService;

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody @Valid SignupRequest signupRequest){
        //TODO : HMAC을 통한 검증 로직 추가 필요
        loginService.signUp(signupRequest);
        return ResponseEntity.ok().body("Successfully Signup");
    }

    @PostMapping("/signin")
    public ResponseEntity<SigninResponse> signin(@RequestBody @Valid SigninRequest signinRequest){
        //TODO : HMAC을 통한 검증 로직 추가 필요
        SigninResponse response = loginService.signIn(signinRequest);
        return ResponseEntity.ok().body(response);
    }


}
