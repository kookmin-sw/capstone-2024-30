package com.example.capstone.domain.jwt;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

@Getter
@AllArgsConstructor
public class PrincipalDetails{
    private String uuid;
    private String name;
    private String major;
    private boolean lock;
    private Collection<? extends GrantedAuthority> authorities;
}
