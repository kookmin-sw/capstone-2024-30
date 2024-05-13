package com.example.capstone.domain.help.dto;

public record HelpListRequest(
        Long cursorId,
        Boolean isDone,
        Boolean isHelper,
        String isMine
) {
}
