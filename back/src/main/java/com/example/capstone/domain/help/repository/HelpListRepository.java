package com.example.capstone.domain.help.repository;

import com.example.capstone.domain.help.dto.HelpSliceResponse;
import org.springframework.data.domain.Pageable;

public interface HelpListRepository {
    HelpSliceResponse getHelpListByPaging(Long cursorId, Pageable page, Boolean isDone, Boolean isHelper, String isMine);
}
