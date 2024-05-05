package com.example.capstone.domain.jwt;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

@Getter
@AllArgsConstructor
public class PrincipalDetails implements Authentication {
    private String uuid;
    private String email;
    private String name;
    private String major;
    private String country;
    private String phoneNumber;
    private boolean lock;
    private Collection<? extends GrantedAuthority> authorities;

    @Override
    public Object getCredentials() {
        return null;
    }

    @Override
    public Object getDetails() {
        return null;
    }

    @Override
    public PrincipalDetails getPrincipal() {
        return this;
    }

    @Override
    public boolean isAuthenticated() {
        return !this.lock;
    }

    @Override
    public void setAuthenticated(boolean isAuthenticated) throws IllegalArgumentException {
        this.lock = isAuthenticated;
    }
}
