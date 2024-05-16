package com.example.capstone.domain.qna.controller;

import com.example.capstone.domain.qna.dto.*;
import com.example.capstone.domain.qna.service.AnswerService;
import com.example.capstone.domain.like.service.LikeService;
import com.example.capstone.global.dto.ApiResult;
import com.example.capstone.global.util.Timer;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/answer")
public class AnswerController {
    private final AnswerService answerService;
    private final LikeService likeService;

    @Timer
    @PostMapping("/create")
    @Operation(summary = "댓글 생성", description = "request 정보를 기반으로 댓글을 생성합니다.")
    @ApiResponse(responseCode = "200", description = "생성된 댓글을 반환합니다.")
    public ResponseEntity<ApiResult<AnswerResponse>> createAnswer(@RequestHeader("X-User-ID") String userId,
                                            @Parameter(description = "댓글의 구성요소 입니다. 질문글의 id, 작성자, 댓글내용이 필요합니다.", required = true)
                                            @RequestBody AnswerPostRequest request) {
        AnswerResponse answer = answerService.createAnswer(userId, request);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully create answer",answer));
    }

    @Timer
    @PostMapping("/list")
    @Operation(summary = "댓글 리스트 생성", description = "request 정보를 기반으로 댓글의 리스트를 생성합니다.")
    @ApiResponse(responseCode = "200", description = "request 정보를 기반으로 생성된 댓글의 리스트가 반환됩니다.")
    public ResponseEntity<ApiResult<AnswerSliceResponse>> listAnswer(@RequestHeader("X-User-ID") String userId,
                                        @Parameter(description = "댓글 리스트 생성을 위한 파라미터 값입니다. 질문글의 id, cursorId, 댓글 정렬 기준( date / like )이 필요합니다.", required = true)
                                        @RequestBody AnswerListRequest request) {
        AnswerSliceResponse response = answerService.getAnswerList(request.questionId(), request.cursorId(), request.sortBy(), userId);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully create answer list", response));
    }

    @Timer
    @PutMapping("/update")
    @Operation(summary = "댓글 수정", description = "request 정보를 기반으로 댓글을 수정합니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200을 반환됩니다.")
    public ResponseEntity<ApiResult<Integer>> updateAnswer(@RequestHeader("X-User-ID") String userId,
                                            @Parameter(description = "댓글 수정을 위한 파라미터입니다. 댓글 id, 질문글 id, 작성자, 댓글 내용이 필요합니다.", required = true)
                                            @RequestBody AnswerPutRequest request) {
        answerService.updateAnswer(userId, request);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully update answer", 200));
    }

    @Timer
    @DeleteMapping("/erase")
    @Operation(summary = "질문글 삭제", description = "댓글 id를 통해 해당글을 삭제합니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200이 반환됩니다.")
    public ResponseEntity<ApiResult<Integer>> eraseAnswer(   @Parameter(description = "삭제할 댓글의 id가 필요합니다.", required = true)
                                            @RequestParam Long id) {
        answerService.eraseAnswer(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully delete answer", 200));
    }

    @Timer
    @PutMapping("/like")
    @Operation(summary = "댓글 추천", description = "해당 id의 댓글을 추천합니다. 현재 추천 댓글 여부를 관리하지 않습니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200을 반환합니다.")
    public ResponseEntity<ApiResult<Integer>> upLikeCount(@RequestHeader("X-User-ID") String userId,
                                            @Parameter(description = "추천할 댓글의 id가 필요합니다.", required = true)
                                            @RequestParam Long id) {
        likeService.likeAnswer(userId, id);
        answerService.increaseLikeCountById(id);

        return ResponseEntity
                .ok(new ApiResult<>("Successfully like answer", 200));
    }

    @Timer
    @PutMapping("/unlike")
    @Operation(summary = "댓글 추천 해제", description = "해당 id의 댓글을 추천 해제합니다. 현재 추천 댓글 여부를 관리하지 않습니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200을 반환합니다.")
    public ResponseEntity<ApiResult<Integer>> downLikeCount(@RequestHeader("X-User-ID") String userId,
                                            @Parameter(description = "추천 해제할 댓글의 id가 필요합니다.", required = true)
                                            @RequestParam Long id) {
        likeService.unlikeAnswer(userId, id);
        answerService.decreaseLikeCountById(id);

        return ResponseEntity
                .ok(new ApiResult<>("Successfully unlike answer", 200));
    }
}
