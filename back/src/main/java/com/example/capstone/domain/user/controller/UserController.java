package com.example.capstone.domain.user.controller;

import com.example.capstone.domain.jwt.PrincipalDetails;
import com.example.capstone.domain.user.dto.SigninRequest;
import com.example.capstone.domain.auth.dto.TokenResponse;
import com.example.capstone.domain.user.dto.SignupRequest;
import com.example.capstone.domain.user.dto.UserProfileUpdateRequest;
import com.example.capstone.domain.user.entity.User;
import com.example.capstone.domain.user.service.LoginService;
import com.example.capstone.domain.user.service.UserService;
import com.example.capstone.domain.user.util.UserMapper;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {
    private final LoginService loginService;
    private final UserService userService;

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

    @GetMapping("")
    public ResponseEntity<User> getMyProfile(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        User user = UserMapper.INSTANCE.principalDetailsToUser(principalDetails);
        return ResponseEntity
                .ok()
                .body(user);
    }

    @PutMapping("")
    public ResponseEntity<User> updateProfile(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                              @RequestBody @Valid final UserProfileUpdateRequest userProfileUpdateRequest) {
        String UUID = principalDetails.getUuid();
        User user = userService.updateUser(UUID, userProfileUpdateRequest);
        return ResponseEntity
                .ok(user);
    }

    @GetMapping("/{userId}")
    public ResponseEntity<User> getUserInfo(@PathVariable String userId) {
        User user = userService.getUserInfo(userId);
        return ResponseEntity
                .ok(user);
    }
}
