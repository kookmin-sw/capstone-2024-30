package com.example.capstone.domain.help.dto;

import java.util.List;

public record HelpSliceResponse(

        Long lastCursorId,

        Boolean hasNext,
        List<HelpListResponse> helpList
) {
}
