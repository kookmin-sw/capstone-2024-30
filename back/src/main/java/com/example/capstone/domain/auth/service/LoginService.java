package com.example.capstone.domain.auth.service;

import com.example.capstone.domain.auth.dto.SignupRequest;
import com.example.capstone.domain.auth.exception.AlreadyEmailExistException;
import com.example.capstone.domain.user.entity.User;
import com.example.capstone.domain.user.repository.UserRepository;
import com.example.capstone.domain.user.util.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class LoginService {
    private final UserRepository userRepository;

    public void emailExists(String email) {
        boolean exist = userRepository.existsByEmail(email);
        if(exist) throw new AlreadyEmailExistException(email);
    }

    public void Signup(SignupRequest dto){
        User user = UserMapper.INSTANCE.signupReqeustToUser(dto);
        emailExists(user.getEmail());
        userRepository.save(user);
    }
}
