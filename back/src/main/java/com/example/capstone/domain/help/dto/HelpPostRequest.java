package com.example.capstone.domain.help.dto;

import java.time.LocalDateTime;
import java.util.UUID;

public record HelpPostRequest(
        String title,
        String author,
        String country,
        String context,
        boolean isHelper
) {
}
