package com.example.capstone.domain.user.service;

import com.example.capstone.domain.user.dto.UserProfileUpdateRequest;
import com.example.capstone.domain.user.entity.User;
import com.example.capstone.domain.user.exception.UserNotFoundException;
import com.example.capstone.domain.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserService {
    private final UserRepository userRepository;
    @Transactional
    public User updateUser(String UUID, UserProfileUpdateRequest dto){
        User user = userRepository.findUserById(UUID)
                .orElseThrow(() -> new UserNotFoundException(UUID));
        user.updateProfile(dto.name(), dto.major(), dto.country(), dto.phoneNumber());
        return user;
    }

    @Transactional
    public User getUserInfo(String userId){
        return userRepository.findUserById(userId)
                .orElseThrow(() -> new UserNotFoundException(userId));
    }
}
