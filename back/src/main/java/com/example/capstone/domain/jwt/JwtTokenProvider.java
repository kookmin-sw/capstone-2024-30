package com.example.capstone.domain.jwt;

import com.example.capstone.domain.jwt.exception.JwtTokenInvalidException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.stream.Collectors;

@Slf4j
@Component
public class JwtTokenProvider {
    private final Key key;
    private long accessExpirationTime;

    public JwtTokenProvider(@Value("${jwt.secret}") String secret,
                            @Value("${jwt.token.access-expiration-time}") long accessExpirationTime){
        byte[] keyBytes = Decoders.BASE64.decode(secret);
        this.key = Keys.hmacShaKeyFor(keyBytes);
        this.accessExpirationTime = accessExpirationTime;
    }

    public String createAccessToken(PrincipalDetails authentication){
        String authorities = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.joining(","));

        Date now = new Date();
        Date expireDate = new Date(now.getTime() + accessExpirationTime);



        return Jwts.builder()
                .claim(JwtClaim.AUTHORITIES.getKey(), authorities)
                .claim(JwtClaim.UUID.getKey(),authentication.getUuid())
                .claim(JwtClaim.NAME.getKey(), authentication.getName())
                .claim(JwtClaim.MAJOR.getKey(), authentication.getMajor())
                .setIssuedAt(now)
                .setExpiration(expireDate)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }

    public String createRefreshToken(Authentication authentication){
        //TODO : refreshToken 생성하는거 만들기
        return "";
    }

    public Authentication getAuthentication(String token){
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();

        String userId = claims.get(JwtClaim.UUID.getKey(), String.class);
        String name = claims.get(JwtClaim.NAME.getKey(), String.class);
        String major = claims.get(JwtClaim.MAJOR.getKey(), String.class);

        /**
         * [{"authority": "역할1"}, {"authority": "역할2"}] 이런식으로 들어갑니다.
         * 그래서 이걸 파싱해주는 과정입니다.
         */
        String[] list = claims.get(JwtClaim.AUTHORITIES).toString().split(",");
        Collection<GrantedAuthority> authorities = new ArrayList<>();
        for (String a: list) {
            authorities.add(new SimpleGrantedAuthority(a));
        }

        PrincipalDetails principalDetails = new PrincipalDetails(userId, name, major, false, authorities);

        return new UsernamePasswordAuthenticationToken(principalDetails, "", authorities);
    }

    public boolean validateToken(String token){
        try{
            Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token);
            return true;
        } catch(JwtTokenInvalidException e){
            throw JwtTokenInvalidException.INSTANCE;
        }

    }
}
