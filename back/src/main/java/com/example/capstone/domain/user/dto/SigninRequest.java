package com.example.capstone.domain.user.dto;

import com.example.capstone.global.dto.HmacRequest;
import jakarta.validation.constraints.Email;

import java.util.UUID;

public record SigninRequest(
        String uuid,
        @Email String email
) implements HmacRequest {
    @Override
    public String toHmacString() {
        return String.join("|", uuid, email);
    }
}
