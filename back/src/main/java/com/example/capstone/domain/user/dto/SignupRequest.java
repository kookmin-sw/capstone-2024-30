package com.example.capstone.domain.user.dto;

import com.example.capstone.global.dto.HmacRequest;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record SignupRequest(
        @NotBlank String uuid,
        @Email String email,
        @NotBlank String name,
        @NotBlank String country,
        @Pattern(regexp = "^010-\\d{4}-\\d{4}$") String phoneNumber,
        @NotBlank String bigmajor,
        @NotBlank String major
) implements HmacRequest {

}
