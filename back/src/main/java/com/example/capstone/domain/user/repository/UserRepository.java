package com.example.capstone.domain.user.repository;

import com.example.capstone.domain.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findUserById(String id);
    boolean existsByEmail(String uuid);
}
