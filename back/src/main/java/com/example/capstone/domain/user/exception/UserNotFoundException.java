package com.example.capstone.domain.user.exception;

import com.example.capstone.global.error.exception.EntityNotFoundException;

public class UserNotFoundException extends EntityNotFoundException {
    public UserNotFoundException(String target) {
        super(target + " is not found");
    }
}
