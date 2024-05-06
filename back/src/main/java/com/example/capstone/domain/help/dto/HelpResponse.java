package com.example.capstone.domain.help.dto;

import java.time.LocalDateTime;

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

        String uuid
) {
}
