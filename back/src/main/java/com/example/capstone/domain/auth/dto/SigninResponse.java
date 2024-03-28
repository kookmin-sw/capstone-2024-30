package com.example.capstone.domain.auth.dto;

public record SigninResponse(
   String accessToken,
   String refreshToken,
   String uuid,
   String email,
   String name,
   String country,
   String phoneNumber,
   String major
){ }
