package com.example.capstone.domain.auth.jwt;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum JwtClaim {
    UUID("uuid"),
    NAME("name"),
    MAJOR("major"),
    AUTHORITIES("authorities");

    private final String key;
}
