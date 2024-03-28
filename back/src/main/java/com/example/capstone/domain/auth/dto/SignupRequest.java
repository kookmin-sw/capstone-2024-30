package com.example.capstone.domain.auth.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record SignupRequest(
        @NotBlank String uuid,
        @Email String email,
        @NotBlank String name,
        @NotBlank String country,
        @Pattern(regexp = "[0-9]{10,11}") String phoneNumber,
        @NotBlank String major
){ }
