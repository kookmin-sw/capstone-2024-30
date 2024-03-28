package com.example.capstone.domain.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;

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

    public String createAccessToken(Authentication authentication){
        Claims claims = Jwts.claims().setSubject(authentication.getName());
        Date now = new Date();
        Date expireDate = new Date(now.getTime() + accessExpirationTime);

        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(expireDate)
                .signWith(key, SignatureAlgorithm.ES256)
                .compact();
    }

    public String createRefreshToken(Authentication authentication){
        //TODO : refreshToken 생성하는거 만들기
        return "";
    }

//    public Authentication getAuthentication(String token){
//        Claims claims = Jwts.parserBuilder()
//                .setSigningKey(key)
//                .build()
//                .parseClaimsJws(token)
//                .getBody();
//
//        UserDetails userDetails = userDetailsService.loadUserByUsername(userPrincipal);
//
//        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
//    }

    public boolean validateToken(String token){
        try{
            Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token);
            return true;
        }
        catch(SecurityException e){
            //TODO : JWTException처리
            log.info("Unexptected Exception", e);
            throw e;
        }
    }
}
