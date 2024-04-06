package com.example.capstone.domain.menu.controller;

import com.example.capstone.domain.menu.service.MenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
public class MenuController {
    private final MenuService menuService;

    @ResponseBody
    @GetMapping("/api/menu/daily")
    public String getMenuByDate(@RequestBody LocalDateTime date, @RequestBody String language){
        return menuService.findMenuByDate(date, language);
    }
}
