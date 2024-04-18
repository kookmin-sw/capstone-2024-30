package com.example.capstone.domain.menu.controller;

import com.example.capstone.domain.menu.service.MenuService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
@RequestMapping("/api/menu")
@RequiredArgsConstructor
public class MenuController {
    private final MenuService menuService;

    @ResponseBody
    @GetMapping("/daily")
    public ResponseEntity<String> getMenuByDate(@RequestParam LocalDateTime date, @RequestParam String language){
        String menu = menuService.findMenuByDate(date, language);
        return ResponseEntity.ok(menu);
    }

    @PostMapping("/test")
    @Operation(summary = "학식 파싱", description = "[주의 : 테스트용] 강제로 학생 저장을 시킴 (DB 중복해서 들어가니깐 물어보고 쓰세요!!)")
    public ResponseEntity<?> testMenu(@RequestParam(value = "key") String key){
        menuService.testKeyCheck(key);
        menuService.crawlingMenu();
        return ResponseEntity.ok("");
    }

}
