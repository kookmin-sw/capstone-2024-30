package com.example.capstone.domain.jwt;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.UUID;

@Getter
@AllArgsConstructor
public class PrincipalDetails implements UserDetails {
    private UUID uuid;
    private String name;
    private String major;
    private boolean lock;
    private Collection<? extends GrantedAuthority> authorities;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {return this.authorities;}

    @Override
    public String getPassword() {return null;}

    @Override
    public String getUsername() {return this.name;}

    @Override
    public boolean isAccountNonExpired() {return false;}

    @Override
    public boolean isAccountNonLocked() {return this.lock;}

    @Override
    public boolean isCredentialsNonExpired() {return false;}

    @Override
    public boolean isEnabled() {
        return false;
    }
}
