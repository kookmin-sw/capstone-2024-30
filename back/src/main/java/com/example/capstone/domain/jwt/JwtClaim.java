package com.example.capstone.domain.jwt;

public enum JwtClaim {
    UUID("uuid"),
    NAME("name"),
    MAJOR("major"),
    AUTHORITIES("authorities");

    private String key;

    JwtClaim(final String key){
        this.key = key;
    }

    public String getKey() {
        return key;
    }
}
