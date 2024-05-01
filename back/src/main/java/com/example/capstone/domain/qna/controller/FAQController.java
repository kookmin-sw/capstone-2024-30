package com.example.capstone.domain.qna.controller;

import com.example.capstone.domain.jwt.JwtTokenProvider;
import com.example.capstone.domain.qna.dto.FAQListRequest;
import com.example.capstone.domain.qna.dto.FAQPostRequest;
import com.example.capstone.domain.qna.dto.FAQPutRequest;
import com.example.capstone.domain.qna.dto.FAQResponse;
import com.example.capstone.domain.qna.entity.FAQ;
import com.example.capstone.domain.qna.service.FAQService;
import com.example.capstone.domain.qna.service.ImageService;
import com.example.capstone.global.dto.ApiResult;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.springframework.http.HttpStatus.CREATED;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/faq")
public class FAQController {
    private final FAQService faqService;

    private final ImageService imageService;

    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/create")
    @Operation(summary = "FAQ글 생성", description = "request 정보를 기반으로 FAQ글을 생성합니다. imgList 정보를 통해 이미지 파일을 업로드 합니다")
    @ApiResponse(responseCode = "200", description = "request 정보를 기반으로 생성된 FAQ글과 imgList을 통해 업로드된 이미지 파일의 url 정보가 함께 반환됩니다.")
    public ResponseEntity<?> createFAQ( @Parameter(description = "FAQ글 생성을 위한 파라미터입니다. 제목, 작성자, 질문, 답변, 언어, 태그값이 필요합니다.", required = true)
                                        @RequestPart FAQPostRequest request,
                                        @Parameter(description = "FAQ글에 첨부될 이미지입니다. List 형태로 입력되야 합니다.")
                                        @RequestPart(required = false) List<MultipartFile> imgList) {
        List<String> urlList = new ArrayList<>();
        FAQResponse faq = faqService.createFAQ(request);
        if(imgList != null) {
            System.out.println(imgList.size());
            urlList = imageService.upload(imgList, faq.id(), true);
        }
        return ResponseEntity
                .ok(new ApiResult<>("Successfully create FAQ", Map.of("content", faq, "imgUrl", urlList)));
    }

    @GetMapping("/read")
    @Operation(summary = "FAQ글 읽기", description = "FAQ글을 읽어 반환합니다.")
    @ApiResponse(responseCode = "200", description = "FAQ글의 내용이 담긴 content와 첨부이미지 주소가 담긴 imgUrl이 반환됩니다.")
    public ResponseEntity<?> readFAQ(   @Parameter(description = "읽을 FAQ글의 id가 필요합니다.", required = true)
                                        @RequestParam Long id) {
        FAQResponse faqResponse = faqService.getFAQ(id);
        List<String> urlList = imageService.getUrlListByFAQId(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully read FAQ", Map.of("content", faqResponse, "imgUrl", urlList)));
    }

    @PutMapping("/update")
    @Operation(summary = "FAQ글 수정", description = "FAQ글을 수정합니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200을 반환합니다.")
    public ResponseEntity<?> updateFAQ( @Parameter(description = "FAQ글 수정을 위한 파라미터입니다. FAQ글 id, 제목, 작성자, 질문, 답변, 언어, 태그값이 필요합니다.", required = true)
                                        @RequestBody FAQPutRequest request) {
        faqService.updateFAQ(request);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully update FAQ", 200));
    }

    @DeleteMapping("/erase")
    @Operation(summary = "FAQ글 삭제", description = "FAQ글을 삭제합니다.")
    @ApiResponse(responseCode = "200", description = "완료시 200을 반환합니다.")
    public ResponseEntity<?> eraseFAQ(  @Parameter(description = "삭제할 FAQ글의 id가 필요합니다.", required = true)
                                        @RequestParam Long id) {
        List<String> urlList = imageService.getUrlListByFAQId(id);
        for(String url : urlList) {
            imageService.deleteImageFromS3(url);
        }
        faqService.eraseFAQ(id);
        imageService.deleteByFAQId(id);
        return ResponseEntity
                .ok(new ApiResult<>("Successfully delete FAQ", 200));
    }

    @GetMapping("/list")
    @Operation(summary = "FAQ글의 미리보기 리스트 생성", description = "FAQ글 리스트를 생성하여 반환합니다.")
    @ApiResponse(responseCode = "200", description = "FAQ글의 미리보기 리스트가 반환됩니다.")
    public ResponseEntity<?> listFAQ(   @Parameter(description = "FAQ글 리스트를 생성하기 위한 파라미터입니다. cursorId, 언어, 검색어, 태그값이 필요합니다.", required = true)
                                        @RequestBody FAQListRequest request) {
        Map<String, Object> response = faqService.getFAQList(request.cursorId(), request.language(), request.word(), request.tag());
        return ResponseEntity
                .ok(new ApiResult<>("Successfully create FAQ list", response));
    }
}
