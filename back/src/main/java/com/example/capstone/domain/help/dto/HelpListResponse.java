package com.example.capstone.domain.help.dto;

import java.time.LocalDateTime;

public record HelpListResponse(
        Long id,

        String title,

        String author,

        String country,

        LocalDateTime createdDate,

        Boolean isDone,

        Boolean isHelper
) {
}
