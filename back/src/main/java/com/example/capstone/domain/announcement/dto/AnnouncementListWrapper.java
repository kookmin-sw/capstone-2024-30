package com.example.capstone.domain.announcement.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;

import java.util.List;

@Getter
@AllArgsConstructor
public class AnnouncementListWrapper{
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long lastCursorId;

    private Boolean hasNext;
    private List<AnnouncementListResponse> announcements;

    public void setLastCursorId(Long lastCursorId){
        this.lastCursorId = lastCursorId;
    }
}
