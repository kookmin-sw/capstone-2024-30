package com.example.capstone.domain.help.dto;

import java.time.LocalDateTime;

public record HelpPostRequest(
        String title,
        String author,
        String country,
        String context,
        boolean isHelper
) {
}
