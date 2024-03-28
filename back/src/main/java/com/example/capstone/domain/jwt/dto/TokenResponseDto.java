package com.example.capstone.domain.jwt.dto;

public record TokenResponseDto(
   String accessToken,
   String refreshToken
){ }
