package com.example.capstone.domain.help.dto;

import jakarta.persistence.Column;

import java.time.LocalDateTime;
import java.util.UUID;

public record HelpResponse(
        Long id,

        boolean isDone,

        boolean isHelper,

        String title,

        String context,

        String author,

        String country,

        LocalDateTime createdDate,

        LocalDateTime updatedDate,

        UUID uuid
) {
}
