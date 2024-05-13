package com.example.capstone.domain.user.dto;

import com.example.capstone.global.dto.HmacRequest;
import jakarta.validation.constraints.Email;

public record SigninRequest(
        String uuid,
        @Email String email
) implements HmacRequest {

}
