package com.example.capstone.domain.jwt;

import com.example.capstone.domain.jwt.exception.JwtTokenInvalidException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;
import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtTokenProvider {
    private final RedisTemplate<String, String> redisTemplate;

    private Key key;

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.token.access-expiration-time}")
    private long accessExpirationTime;

    @Value("${jwt.token.refresh-expiration-time}")
    private long refreshExpirationTime;

    @PostConstruct
    public void init() {
        byte[] keyBytes = Decoders.BASE64.decode(secret);
        this.key = Keys.hmacShaKeyFor(keyBytes);
    }

    public String createAccessToken(PrincipalDetails authentication) {
        String authorities = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.joining(","));

        Date now = new Date();
        Date expireDate = new Date(now.getTime() + accessExpirationTime);

        return Jwts.builder()
                .claim(JwtClaim.AUTHORITIES.getKey(), authorities)
                .claim(JwtClaim.UUID.getKey(), authentication.getUuid())
                .claim(JwtClaim.NAME.getKey(), authentication.getName())
                .claim(JwtClaim.EMAIL.getKey(), authentication.getEmail())
                .claim(JwtClaim.MAJOR.getKey(), authentication.getMajor())
                .claim(JwtClaim.COUNTRY.getKey(), authentication.getCountry())
                .claim(JwtClaim.PHONENUMBER.getKey(), authentication.getPhoneNumber())
                .setIssuedAt(now)
                .setExpiration(expireDate)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }

    public String createRefreshToken(PrincipalDetails authentication) {
        String authorities = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.joining(","));

        Date now = new Date();
        Date expireDate = new Date(now.getTime() + refreshExpirationTime);

        String refreshToken = Jwts.builder()
                .claim(JwtClaim.AUTHORITIES.getKey(), authorities)
                .claim(JwtClaim.UUID.getKey(), authentication.getUuid())
                .claim(JwtClaim.NAME.getKey(), authentication.getName())
                .claim(JwtClaim.EMAIL.getKey(), authentication.getEmail())
                .claim(JwtClaim.COUNTRY.getKey(), authentication.getCountry())
                .claim(JwtClaim.PHONENUMBER.getKey(), authentication.getPhoneNumber())
                .claim(JwtClaim.MAJOR.getKey(), authentication.getMajor())
                .claim(JwtClaim.AUTHORITIES.getKey(), authentication.getAuthorities())
                .setIssuedAt(now)
                .setExpiration(expireDate)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();

        redisTemplate.opsForValue().set(
                authentication.getUuid(),
                refreshToken,
                refreshExpirationTime,
                TimeUnit.MICROSECONDS
        );

        return refreshToken;
    }

    public Authentication getAuthentication(String token) {
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();

        String userId = claims.get(JwtClaim.UUID.getKey(), String.class);
        String email = claims.get(JwtClaim.EMAIL.getKey(), String.class);
        String name = claims.get(JwtClaim.NAME.getKey(), String.class);
        String country = claims.get(JwtClaim.COUNTRY.getKey(), String.class);
        String phoneNumber = claims.get(JwtClaim.PHONENUMBER.getKey(), String.class);
        String major = claims.get(JwtClaim.MAJOR.getKey(), String.class);

        /**
         * [{"authority": "역할1"}, {"authority": "역할2"}] 이런식으로 들어갑니다.
         * 그래서 이걸 파싱해주는 과정입니다.
         */
        String[] list = claims.get(JwtClaim.AUTHORITIES.getKey()).toString().split(",");
        Collection<GrantedAuthority> authorities = new ArrayList<>();
        for (String a : list) {
            authorities.add(new SimpleGrantedAuthority(a));
        }

        PrincipalDetails principalDetails = new PrincipalDetails(userId, email, name, major,
                country, phoneNumber, false, authorities);

        return new UsernamePasswordAuthenticationToken(principalDetails, "", authorities);
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token);
            return true;
        } catch (JwtException e) {
            throw JwtTokenInvalidException.INSTANCE;
        }

    }

    /**
     * 좀만 고민해보고 폐기 예정
     */
    private Claims parseClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = parseClaims(token);
        return claimsResolver.apply(claims);
    }

    public String extractUUID(String token) {
        return extractClaim(token, claims -> claims.get(JwtClaim.UUID.getKey(), String.class));
    }
}
