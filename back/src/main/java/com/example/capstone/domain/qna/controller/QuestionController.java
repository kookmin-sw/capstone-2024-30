package com.example.capstone.domain.qna.controller;

import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.qna.dto.*;
import com.example.capstone.domain.qna.entity.Question;
import com.example.capstone.domain.qna.service.ImageService;
import com.example.capstone.domain.qna.service.QuestionService;
import com.example.capstone.global.dto.ApiResult;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

import static org.springframework.http.HttpStatus.CREATED;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/question")
public class QuestionController {

    private final QuestionService questionService;
    private final ImageService imageService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping(value = "/create", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Operation(summary = "질문글 생성", description = "request 정보를 기반으로 질문글을 생성합니다. imgList 정보를 통해 이미지 파일을 업로드 합니다")
    @ApiResponse(responseCode = "200", description = "request 정보를 기반으로 생성된 질문글과 imgList을 통해 업로드된 이미지 파일의 url 정보가 함께 반환됩니다.")
    public ResponseEntity<ApiResult<QuestionEntireResponse>> createQuestion(@RequestHeader("X-User-ID") String userId,
                                            @Parameter(description = "질문글의 구성 요소 입니다. 제목, 작성자, 본문, 태그, 국가 정보가 들어가야 합니다.", required = true)
                                            @RequestPart QuestionPostRequest request,
                                            @Parameter(description = "질문글에 첨부되는 이미지 파일들 입니다. 여러 파일을 리스트 형식으로 입력해야 합니다.")
                                            @RequestPart(required = false) List<MultipartFile> imgList) {
        List<String> urlList = new ArrayList<>();
        QuestionResponse quest = questionService.createQuestion(userId, request);
        if(imgList != null){
            urlList = imageService.upload(imgList, quest.id(), false);
        }
        return ResponseEntity
                .ok(new ApiResult<>("Successfully create question", new QuestionEntireResponse(quest, urlList)));
    }

    @GetMapping("/read")
    @Operation(summary = "질문글 불러오기", description = "id를 통해 해당 질문글을 가져옵니다.")
    @ApiResponse(responseCode = "200", description = "해당 id의 질문글과 이미지 url을 반환합니다.")
    public ResponseEntity<ApiResult<QuestionEntireResponse>> readQuestion(
                                            @Parameter(description = "가져올 질문글의 id 입니다.", required = true)
                                            @RequestParam Long id) {
        QuestionResponse questionResponse = questionService.getQuestion(id);
        List<String> urlList = imageService.getUrlListByQuestionId(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully read question", new QuestionEntireResponse(questionResponse, urlList)));
    }

    @PutMapping("/update")
    @Operation(summary = "질문글 수정", description = "request 정보를 기반으로 질문글을 수정합니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200을 리턴합니다.")
    public ResponseEntity<ApiResult<Integer>> updateQuestion(/*@RequestHeader String token,*/
                                            @Parameter(description = "수정할 질문글의 id와 질문글의 request가 들어갑니다.", required = true)
                                            @RequestBody QuestionPutRequest request) {
        String userId = UUID.randomUUID().toString();//jwtTokenProvider.extractUUID(token);
        questionService.updateQuestion(userId, request);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully update question", 200));
    }

    @DeleteMapping("/erase")
    @Operation(summary = "질문글 삭제", description = "id를 기반으로 해당 질문글을 삭제합니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200을 리턴합니다.")
    public ResponseEntity<ApiResult<Integer>> eraseQuestion(
                                            @Parameter(description = "삭제할 질문글의 id 입니다.", required = true)
                                            @RequestParam Long id) {
        List<String> urlList = imageService.getUrlListByQuestionId(id);
        for(String url : urlList) {
            imageService.deleteImageFromS3(url);
        }
        questionService.eraseQuestion(id);
        imageService.deleteByQuestionId(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully delete question", 200));
    }

    @PostMapping("/list")
    @Operation(summary = "질문글 미리보기 리스트 생성", description = "request 정보를 기반으로 페이지네이션이 적용된 질문글 리스트를 반환합니다.")
    @ApiResponse(responseCode = "200", description = "request 조건에 맞는 질문글 리스트를 반환합니다.")
    public ResponseEntity<ApiResult<QuestionSliceResponse>> listQuestion(
                                            @Parameter(description = "질문글 리스트를 위한 cursorId, 검색어 word, 태그값 tag가 필요합니다.", required = true)
                                            @RequestBody QuestionListRequest request) {
        QuestionSliceResponse response = questionService.getQuestionList(request);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully create question list", response));
    }
}
