package com.example.capstone.domain.announcement.exception;

import com.example.capstone.global.error.exception.EntityNotFoundException;

public class AnnouncementNotFoundException extends EntityNotFoundException {
    public AnnouncementNotFoundException(Long id) {
        super(id + " is not found");
    }
}

