package com.example.capstone.domain.user.dto;

import jakarta.validation.constraints.Email;

import java.util.UUID;

public record SigninRequest(
        String uuid,
        @Email String email
) {
}
