package com.example.capstone.domain.help.dto;

import java.util.UUID;

public record HelpListRequest(
        Long cursorId,
        Boolean isDone,
        Boolean isHelper,
        UUID isMine
) {
}
