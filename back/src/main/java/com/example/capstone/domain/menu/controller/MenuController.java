package com.example.capstone.domain.menu.controller;

import com.example.capstone.domain.menu.service.MenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
public class MenuController {
    private final MenuService menuService;

    @GetMapping("/api/menu/test")
    public void getMenuTest(){
        LocalDateTime test = LocalDateTime.of(2024, 3, 26, 0, 0);
        menuService.addMenus(test, test, test);
    }
}
