package com.example.capstone.domain.jwt;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum JwtClaim {
    UUID("uuid"),
    NAME("name"),
    EMAIL("email"),
    COUNTRY("country"),
    PHONENUMBER("phoneNumber"),
    MAJOR("major"),
    AUTHORITIES("authorities");

    private final String key;
}
