package com.example.capstone.domain.help.exception;

import com.example.capstone.global.error.exception.EntityNotFoundException;

public class HelpNotFoundException extends EntityNotFoundException {
    public HelpNotFoundException(Long id) {
        super(id + " is not found help");
    }
}
