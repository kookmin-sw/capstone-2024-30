package com.example.capstone.domain.user.service;

import com.example.capstone.domain.user.dto.SigninRequest;
import com.example.capstone.domain.auth.dto.TokenResponse;
import com.example.capstone.domain.user.dto.SignupRequest;
import com.example.capstone.domain.user.dto.UserProfileUpdateRequest;
import com.example.capstone.domain.user.exception.AlreadyEmailExistException;
import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.jwt.PrincipalDetails;
import com.example.capstone.domain.user.entity.User;
import com.example.capstone.domain.user.exception.UserNotFoundException;
import com.example.capstone.domain.user.repository.UserRepository;
import com.example.capstone.domain.user.util.UserMapper;
import com.example.capstone.global.dto.HmacRequest;
import com.example.capstone.global.error.exception.BusinessException;
import com.example.capstone.global.error.exception.EntityNotFoundException;
import com.example.capstone.global.error.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.apache.coyote.Request;
import org.apache.tomcat.util.buf.HexUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Collections;
import java.util.Objects;

import static com.example.capstone.global.error.exception.ErrorCode.HMAC_NOT_VALID;
import static com.example.capstone.global.error.exception.ErrorCode.USER_NOT_FOUND;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class LoginService {
    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;

    @Value("${HMAC_SECRET}")
    private String key;

    @Value("${HMAC_ALGORITHM}")
    private String algorithm;

    public void verifyHmac(String hmac, HmacRequest request) {
        try{
            String hashed = calculateHMAC(request.toHmacString());
            byte[] decodedBytes = Base64.getDecoder().decode(hmac);
            String decoded = HexUtils.toHexString(decodedBytes);

            if(!decoded.equals(hashed)) {
                throw new BusinessException(HMAC_NOT_VALID);
            }
        }
        catch (Exception e){
            throw new BusinessException(HMAC_NOT_VALID);
        }
    }

    private String calculateHMAC(String data) throws NoSuchAlgorithmException, InvalidKeyException {
        byte[] decodedKey = Base64.getDecoder().decode(key);
        SecretKey secretKey = new SecretKeySpec(decodedKey, algorithm);
        Mac hasher = Mac.getInstance(algorithm);
        hasher.init(secretKey);
        byte[] rawHmac = hasher.doFinal(data.getBytes(StandardCharsets.UTF_8));
        String hashed = HexUtils.toHexString(rawHmac);

        return hashed;
    }

    public void emailExists(String email) {
        boolean exist = userRepository.existsByEmail(email);
        if (exist) throw new AlreadyEmailExistException(email);
    }

    @Transactional
    public void signUp(SignupRequest dto) {
        User user = UserMapper.INSTANCE.signupReqeustToUser(dto);
        System.out.println(user.getId());
        System.out.println(user.getEmail());
        emailExists(user.getEmail());
        userRepository.save(user);
    }

    @Transactional
    public TokenResponse signIn(SigninRequest dto) {
        String uuid = dto.uuid();
        User user = userRepository.findUserById(uuid)
                .orElseThrow(() -> new UserNotFoundException(uuid));

        PrincipalDetails principalDetails = new PrincipalDetails(user.getId(),
                user.getName(), user.getEmail(), user.getMajor(), user.getCountry(), user.getPhoneNumber(),
                false, Collections.singleton(new SimpleGrantedAuthority("ROLE_USER")));

        String accessToken = jwtTokenProvider.createAccessToken(principalDetails);
        String refreshToken = jwtTokenProvider.createRefreshToken(principalDetails);

        return TokenResponse
                .builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }
}
