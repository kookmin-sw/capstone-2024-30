package com.example.capstone.domain.help.repository;

import com.example.capstone.domain.help.dto.HelpListResponse;
import com.example.capstone.domain.help.dto.HelpSliceResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

import java.util.Map;
import java.util.UUID;

public interface HelpListRepository {
    HelpSliceResponse getHelpListByPaging(Long cursorId, Pageable page, Boolean isDone, Boolean isHelper, UUID isMine);
}
