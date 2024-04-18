package com.example.capstone.domain.menu.controller;

import com.example.capstone.domain.menu.service.MenuCrawlingService;
import com.example.capstone.domain.menu.service.MenuSearchService;
import com.example.capstone.domain.menu.service.MenuUpdateService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.json.JsonArray;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/api/menu")
@RequiredArgsConstructor
public class MenuController {
    private final MenuCrawlingService menuCrawlingService;
    private final MenuSearchService menuSearchService;

    @ResponseBody
    @GetMapping("/daily")
    public ResponseEntity<?> getMenuByDate(@RequestParam LocalDate date, @RequestParam String language){
        JsonArray menu = menuSearchService.findMenuByDate(date, language);
        return ResponseEntity.ok(menu);
    }

    @PostMapping("test")
    @Operation(summary = "학식 파싱", description = "[주의 : 테스트용] 강제로 학생 저장을 시킴 (DB 중복해서 들어가니깐 물어보고 쓰세요!!)")
    public ResponseEntity<?> testMenu(){
        menuCrawlingService.crawlingMenus();
        return ResponseEntity.ok("");
    }

}
