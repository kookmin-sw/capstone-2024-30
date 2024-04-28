package com.example.capstone.domain.menu.service;

import com.example.capstone.domain.menu.entity.Menu;
import com.example.capstone.domain.menu.repository.MenuRepository;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MenuSearchService {
    private final MenuRepository menuRepository;

    public List<Object> findMenuByDate(LocalDate date, String language) {
        LocalDateTime dateTime = LocalDateTime.of(date, LocalTime.MIN);
        List<String> cafeList = menuRepository.findMenuCafeByDateAndLang(dateTime, language);

        List<Object> response = new ArrayList<>();

        for(String cafe : cafeList) {
            List<Menu> menuList = menuRepository.findMenuByDateAndCafeteria(dateTime, cafe, language);
            Map<String, Object> subInfos = new HashMap<>();
            for(Menu menu : menuList) {
                Map<String, String> menuInfo = Map.of(
                        "메뉴", menu.getName(),
                        "가격", menu.getPrice().toString());
                subInfos.put(menu.getSection(), menuInfo);
            }

            Map<String, Object> cafeInfo = Map.of(
                    cafe, Map.of(
                            date, subInfos));
            response.add(cafeInfo);
        }

        return response;
    }
}