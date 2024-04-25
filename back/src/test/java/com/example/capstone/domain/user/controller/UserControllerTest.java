package com.example.capstone.domain.user.controller;

import com.example.capstone.BaseIntegrationTest;
import com.example.capstone.domain.user.dto.SignupRequest;
import org.apache.tomcat.util.buf.HexUtils;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.ResultActions;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class UserControllerTest extends BaseIntegrationTest {

    @Value("${HMAC_SECRET}")
    private String key;

    @Value("${HMAC_ALGORITHM}")
    private String algorithm;

    final String BASE_URI = "/api/user";
    @Test
    @DisplayName("회원가입 성공")
    @WithMockUser
    void sign_up_success() throws Exception {
        //given
        final SignupRequest request = new SignupRequest(
                "qwrjkjdslkfjlkfs",
                "hongildong@naver.com",
                "Hong Gill Dong",
                "North Korea",
                "010-1234-5678",
                "A O Ji"
        );

        String data = objectMapper.writeValueAsString(request);

        System.out.println(key);
        System.out.println(algorithm);

        byte[] decodedKey = Base64.getDecoder().decode(key);
        SecretKey secretKey = new SecretKeySpec(decodedKey, algorithm);
        Mac hasher = Mac.getInstance(algorithm);
        hasher.init(secretKey);
        byte[] rawHmac = hasher.doFinal(data.getBytes(StandardCharsets.UTF_8));
        System.out.println(HexUtils.toHexString(rawHmac));
        String HMAC = Base64.getEncoder().encodeToString(rawHmac);

        System.out.println(data);
        System.out.println(HMAC);

        //when
        final ResultActions resultActions = mockMvc.perform(
                post(BASE_URI + "/signup")
                        .content(data)
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("HMAC", HMAC)
                        .accept(MediaType.APPLICATION_JSON)
        );

        resultActions
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.message").value("Successfully Signup"));
    }
}