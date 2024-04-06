package com.example.capstone.domain.user.service;

import com.example.capstone.domain.user.dto.SigninRequest;
import com.example.capstone.domain.auth.dto.TokenResponse;
import com.example.capstone.domain.user.dto.SignupRequest;
import com.example.capstone.domain.user.exception.AlreadyEmailExistException;
import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.jwt.PrincipalDetails;
import com.example.capstone.domain.user.entity.User;
import com.example.capstone.domain.user.repository.UserRepository;
import com.example.capstone.domain.user.util.UserMapper;
import com.example.capstone.global.error.exception.BusinessException;
import com.example.capstone.global.error.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class LoginService {
    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;

    public void emailExists(String email) {
        boolean exist = userRepository.existsByEmail(email);
        if(exist) throw new AlreadyEmailExistException(email);
    }

    @Transactional
    public void signUp(SignupRequest dto){
        User user = UserMapper.INSTANCE.signupReqeustToUser(dto);
        System.out.println(user.getId());
        System.out.println(user.getEmail());
        emailExists(user.getEmail());
        userRepository.save(user);
    }

    @Transactional
    public TokenResponse signIn(SigninRequest dto){
        String uuid = dto.uuid();
        //TODO : UserNotFoundException 만들고 throw하기
        User user = userRepository.findUserById(uuid)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));

        PrincipalDetails principalDetails = new PrincipalDetails(user.getId(),
                user.getName(), user.getMajor(), false, Collections.singleton(new SimpleGrantedAuthority("ROLE_USER")));

        String accessToken = jwtTokenProvider.createAccessToken(principalDetails);
        String refreshToken = jwtTokenProvider.createRefreshToken(principalDetails);

        return TokenResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }
}
