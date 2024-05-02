package com.example.capstone.domain.help.controller;

import com.example.capstone.domain.help.dto.*;
import com.example.capstone.domain.help.service.HelpService;
import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.global.dto.ApiResult;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/help")
public class HelpController {

    private final HelpService helpService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping(value = "/create")
    @Operation(summary = "헬퍼글 생성", description = "request 정보를 기반으로 헬퍼글을 생성합니다.")
    @ApiResponse(responseCode = "200", description = "request 정보를 기반으로 생성된 헬퍼글을 반환됩니다.")
    public ResponseEntity<ApiResult<HelpResponse>> createHelp(
                                            @Parameter(description = "헬퍼 모집글의 구성 요소 입니다. 제목, 작성자, 본문, 국가 정보가 들어가야 합니다.", required = true)
                                            @RequestBody HelpPostRequest request) {
        String userId = UUID.randomUUID().toString();//jwtTokenProvider.extractUUID(token);
        HelpResponse helpResponse = helpService.createHelp(userId, request);

        return ResponseEntity
                .ok(new ApiResult<>("Successfully create help", helpResponse));
    }

    @GetMapping("/read")
    @Operation(summary = "헬퍼글 불러오기", description = "id를 통해 해당 글을 가져옵니다.")
    @ApiResponse(responseCode = "200", description = "해당 id의 글을 반환합니다.")
    public ResponseEntity<ApiResult<HelpResponse>> readHelp(
            @Parameter(description = "가져올 글의 id 입니다.", required = true)
            @RequestParam Long id) {
        HelpResponse helpResponse = helpService.getHelp(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully read help", helpResponse));
    }

    @PutMapping("/update")
    @Operation(summary = "헬퍼글 수정", description = "request 정보를 기반으로 글을 수정합니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200을 리턴합니다.")
    public ResponseEntity<ApiResult<Integer>> updateHelp(/*@RequestHeader String token,*/
            @Parameter(description = "수정할 헬퍼글의 id와 헬퍼글의 request가 들어갑니다.", required = true)
            @RequestBody HelpPutRequest request) {
        String userId = UUID.randomUUID().toString();//jwtTokenProvider.extractUUID(token);
        helpService.updateHelp(userId, request);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully update help", 200));
    }

    @DeleteMapping("/erase")
    @Operation(summary = "헬퍼글 삭제", description = "id를 기반으로 해당 글을 삭제합니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200을 리턴합니다.")
    public ResponseEntity<ApiResult<Integer>> eraseHelp(
            @Parameter(description = "삭제할 글의 id 입니다.", required = true)
            @RequestParam Long id) {
        helpService.eraseHelp(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully delete help", 200));
    }

    @GetMapping("/list")
    @Operation(summary = "헬퍼글 미리보기 리스트 생성", description = "request 정보를 기반으로 페이지네이션이 적용된 헬퍼글 리스트를 반환합니다.")
    @ApiResponse(responseCode = "200", description = "request 조건에 맞는 헬퍼글 리스트를 반환합니다.")
    public ResponseEntity<ApiResult<HelpSliceResponse>> listHelp(
            @Parameter(description = "헬퍼글 리스트를 위한 cursorId, 검색어 word, 태그값 tag가 필요합니다.", required = true)
            @RequestBody HelpListRequest request) {
        HelpSliceResponse response = helpService.getHelpList(request);

        return ResponseEntity
                .ok(new ApiResult<>("Successfully create help list", response));
    }


}
