package com.example.capstone.domain.user.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record UserProfileUpdateRequest(
        @NotBlank String name,
        @NotBlank String country,
        @Pattern(regexp = "[0-9]{10,11}") String phoneNumber,
        @NotBlank String major,
        @NotBlank String bigmajor
) {
}
