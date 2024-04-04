package com.example.capstone.domain.auth.dto;

import lombok.Builder;

@Builder
public record SigninResponse(
   String accessToken,
   String refreshToken
){ }
