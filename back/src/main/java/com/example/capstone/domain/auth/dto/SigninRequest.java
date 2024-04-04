package com.example.capstone.domain.auth.dto;

import jakarta.validation.constraints.Email;

import java.util.UUID;

public record SigninRequest (
    String uuid,
    @Email String email
){}
