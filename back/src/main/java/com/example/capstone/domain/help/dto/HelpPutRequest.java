package com.example.capstone.domain.help.dto;

public record HelpPutRequest(
        Long id,
        String title,
        String author,
        String country,
        String context,
        boolean isHelper
) {
}
