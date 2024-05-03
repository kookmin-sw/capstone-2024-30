package com.example.capstone.domain.user.controller;

import com.example.capstone.domain.auth.dto.TokenResponse;
import com.example.capstone.domain.jwt.PrincipalDetails;
import com.example.capstone.domain.user.dto.SigninRequest;
import com.example.capstone.domain.user.dto.SignupRequest;
import com.example.capstone.domain.user.dto.UserProfileUpdateRequest;
import com.example.capstone.domain.user.entity.User;
import com.example.capstone.domain.user.service.LoginService;
import com.example.capstone.domain.user.service.UserService;
import com.example.capstone.domain.user.util.UserMapper;
import com.example.capstone.global.dto.ApiResult;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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
    @Operation(summary = "회원가입", description = "FireBase로 인증된 유저를 회원가입 시킵니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "회원가입 성공", useReturnTypeSchema = true),
            @ApiResponse(responseCode = "400", description = "이미 존재하는 이메일", content = @Content(mediaType = "application/json")),
            @ApiResponse(responseCode = "403", description = "HMAC 인증 실패", content = @Content(mediaType = "application/json"))
    })
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<ApiResult<String>> signup(
            @Parameter(description = "HMAC은 데이터 무결성을 위해서 반드시 Base64로 인코딩해서 보내야됩니다.", required = true)
            @RequestHeader(name = "HMAC") String hmac,
            @Parameter(description = "HMAC은 해당 Request의 Value들을 |로 구분자로 넣어서 만든 내용으로 만들면 됩니다.", required = true)
            @RequestBody @Valid SignupRequest signupRequest) {
        log.debug("SignupRequest: {}", signupRequest);
        loginService.verifyHmac(hmac, signupRequest);
        loginService.signUp(signupRequest);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(new ApiResult<>("Successfully Signup", ""));
    }

    @PostMapping("/signin")
    @Operation(summary = "로그인", description = "FireBase로 인증이 완료된 유저를 로그인 시키고 Token을 부여합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "로그인 성공"),
            @ApiResponse(responseCode = "400", description = "존재하지 않는 유저", content = @Content(mediaType = "application/json")),
            @ApiResponse(responseCode = "403", description = "HMAC 인증 실패", content = @Content(mediaType = "application/json"))
    })
    public ResponseEntity<ApiResult<TokenResponse>> signin(@RequestHeader(name = "HMAC") String hmac,
                                                @RequestBody @Valid SigninRequest signinRequest) {
        log.debug("SigninRequest: {}", signinRequest);
        loginService.verifyHmac(hmac, signinRequest);
        TokenResponse response = loginService.signIn(signinRequest);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully Sign in", response));
    }

    @Operation(summary = "내 정보 받아오기", description = "내 정보를 받아옵니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "정보 받기 성공"),
            @ApiResponse(responseCode = "401", description = "유효하지 않은 토큰", content = @Content(mediaType = "application/json"))
    })
    @GetMapping("/me")
    public ResponseEntity<ApiResult<User>> getMyProfile(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        User user = UserMapper.INSTANCE.principalDetailsToUser(principalDetails);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully gey my info", user));
    }


    @PutMapping("/me")
    @Operation(summary = "내 정보 수정하기", description = "내 정보를 수정합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "정보 받기 성공"),
            @ApiResponse(responseCode = "401", description = "유효하지 않은 토큰", content = @Content(mediaType = "application/json")),
            @ApiResponse(responseCode = "403", description = "권한 없음", content = @Content(mediaType = "application/json"))
    })
    public ResponseEntity<ApiResult<User>> updateProfile(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                              @RequestBody @Valid final UserProfileUpdateRequest userProfileUpdateRequest) {
        String UUID = principalDetails.getUuid();
        User user = userService.updateUser(UUID, userProfileUpdateRequest);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully modify my info", user));
    }

    @GetMapping("/{userId}")
    @Operation(summary = "특정 유저 정보 받기", description = "특정 유저 정보를 받아옵니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "정보 받기 성공"),
            @ApiResponse(responseCode = "400", description = "존재하지 않는 유저", content = @Content(mediaType = "application/json")),
    })
    public ResponseEntity<ApiResult<User>> getUserInfo(@PathVariable String userId) {
        User user = userService.getUserInfo(userId);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully get user info", user));
    }

    @GetMapping("/test")
    @Operation(summary = "토큰 내놔", description = "토큰 강제로 내놔.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "정보 받기 성공"),
            @ApiResponse(responseCode = "400", description = "존재하지 않는 유저", content = @Content(mediaType = "application/json")),
    })
    public ResponseEntity<ApiResult<TokenResponse>> test(@RequestParam(value = "key") String key, @RequestParam(value = "id") String userId) {
        loginService.testKeyCheck(key);
        TokenResponse response = loginService.test(userId);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully Sign in", response));
    }
}