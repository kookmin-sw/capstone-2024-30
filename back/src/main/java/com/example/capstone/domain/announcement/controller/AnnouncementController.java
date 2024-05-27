package com.example.capstone.domain.announcement.controller;

import com.example.capstone.domain.announcement.dto.AnnouncementListResponse;
import com.example.capstone.domain.announcement.dto.AnnouncementListWrapper;
import com.example.capstone.domain.announcement.entity.Announcement;
import com.example.capstone.domain.announcement.service.AnnouncementCallerService;
import com.example.capstone.domain.announcement.service.AnnouncementSearchService;
import com.example.capstone.global.dto.ApiResult;
import com.example.capstone.global.error.exception.BusinessException;
import com.example.capstone.global.util.Timer;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Slice;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.example.capstone.global.error.exception.ErrorCode.SEARCH_TOO_SHORT;

@Slf4j
@RestController
@RequestMapping("/api/announcement")
@RequiredArgsConstructor
public class AnnouncementController {
    private final AnnouncementCallerService announcementCallerService;
    private final AnnouncementSearchService announcementSearchService;

    @PostMapping("/test")
    @Operation(summary = "공지사항 크롤링", description = "강제로 공지사항 크롤링을 진행합니다.")
    ResponseEntity<?> test(
            @Parameter(description = "해당 매서드를 실행하기 위해서 관리자 키가 필요합니다.", required = true)
            @RequestParam(value = "key") String key) {
        announcementSearchService.testKeyCheck(key);
        announcementCallerService.crawlingAnnouncement();
        return ResponseEntity
                .ok("");
    }

    @Timer
    @GetMapping("")
    @Operation(summary = "공지사항 받아오기", description = "커서기반으로 공지사항을 받아옵니다")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "정보 받기 성공"),
            @ApiResponse(responseCode = "400", description = "정보 받기 실패", content = @Content(mediaType = "application/json"))
    })
    ResponseEntity<ApiResult<AnnouncementListWrapper>> getAnnouncementList(
            @Parameter(description = "공지사항 유형입니다. 입력하지 않으면 전체를 받아옵니다.")
            @RequestParam(defaultValue = "전체", value = "type") String type,
            @Parameter(description = "공지사항 언어입니다. 입력하지 않으면 한국어로 받아옵니다.")
            @RequestParam(defaultValue = "KO", value = "language") String language,
            @Parameter(description = "어디까지 로드됐는지 가르키는 커서입니다. 입력하지 않으면 처음부터 10개 받아옵니다.")
            @RequestParam(defaultValue = "0", value = "cursor") long cursor
    ) {
        Slice<AnnouncementListResponse> slice = announcementSearchService.getAnnouncementList(cursor, type, language);

        List<AnnouncementListResponse> announcements = slice.getContent();
        boolean hasNext = slice.hasNext();


        AnnouncementListWrapper response = new AnnouncementListWrapper(null, hasNext, announcements);


        if (hasNext && !announcements.isEmpty()) {
            AnnouncementListResponse lastAnnouncement = announcements.get(announcements.size() - 1);
            response.setLastCursorId(lastAnnouncement.id());
        }

        return ResponseEntity
                .ok(new ApiResult<>("Successfully load announcement list", response));
    }

    @Timer
    @GetMapping("/{announcementId}")
    @Operation(summary = "공지사항 세부정보 받아오기", description = "공지사항의 세부적인 내용을 받아옵니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "정보 받기 성공"),
            @ApiResponse(responseCode = "400", description = "정보 받기 실패", content = @Content(mediaType = "application/json"))
    })
    ResponseEntity<ApiResult<Announcement>> getAnnouncementDetail(@PathVariable(value = "announcementId") long announcementId) {
        Announcement announcement = announcementSearchService.getAnnouncementDetail(announcementId);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully load announcement", announcement));
    }

    @Timer
    @GetMapping("/search")
    @Operation(summary = "공지사항 검색기반으로 가져오기", description = "검색한 공지사항을 커서기반으로 받아옵니다. 2글자 이상으로만 검색됩니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "정보 받기 성공"),
            @ApiResponse(responseCode = "400", description = "정보 받기 실패", content = @Content(mediaType = "application/json"))
    })
    ResponseEntity<ApiResult<AnnouncementListWrapper>> getAnnouncementSearchList(
            @Parameter(description = "공지사항 유형입니다. 입력하지 않으면 전체를 받아옵니다.")
            @RequestParam(defaultValue = "전체", value = "type") String type,
            @Parameter(description = "공지사항 언어입니다. 입력하지 않으면 한국어로 받아옵니다.")
            @RequestParam(defaultValue = "KO", value = "language") String language,
            @Parameter(description = "어디까지 로드됐는지 가르키는 커서입니다. 입력하지 않으면 처음부터 10개 받아옵니다.")
            @RequestParam(defaultValue = "0", value = "cursor") long cursor,
            @Parameter(description = "검색어입니다. 문자열을 인코딩해서 보내주셔야됩니다.")
            @RequestParam(value = "word") String word
    ) {
        if (word.length() < 2) throw new BusinessException(SEARCH_TOO_SHORT);


        Slice<AnnouncementListResponse> slice = announcementSearchService.getAnnouncementSearchList(cursor, type,
                language, word);

        List<AnnouncementListResponse> announcements = slice.getContent();
        boolean hasNext = slice.hasNext();


        AnnouncementListWrapper response = new AnnouncementListWrapper(null, hasNext, announcements);


        if (hasNext && !announcements.isEmpty()) {
            AnnouncementListResponse lastAnnouncement = announcements.get(announcements.size() - 1);
            response.setLastCursorId(lastAnnouncement.id());
        }

        return ResponseEntity
                .ok(new ApiResult<>("Successfully load announcement list", response));
    }

}
