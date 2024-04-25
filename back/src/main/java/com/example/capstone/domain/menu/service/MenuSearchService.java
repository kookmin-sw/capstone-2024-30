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
import java.util.List;

@Service
@RequiredArgsConstructor
public class MenuSearchService {
    private final MenuRepository menuRepository;

    public JsonArray findMenuByDate(LocalDate date, String language) {
        LocalDateTime dateTime = LocalDateTime.of(date, LocalTime.MIN);
        List<String> cafeList = menuRepository.findMenuCafeByDateAndLang(dateTime, language);

        JsonArrayBuilder infos = Json.createArrayBuilder();

        for(String cafe : cafeList) {
            List<Menu> menuList = menuRepository.findMenuByDateAndCafeteria(dateTime, cafe, language);
            JsonArrayBuilder subInfos = Json.createArrayBuilder();
            for(Menu menu : menuList) {
                JsonObjectBuilder menuInfo = Json.createObjectBuilder()
                        .add("메뉴", menu.getName())
                        .add("가격", menu.getPrice().toString());
                subInfos.add(menuInfo);
            }
            JsonObjectBuilder cafeInfo = Json.createObjectBuilder()
                    .add(cafe, Json.createObjectBuilder()
                            .add(dateTime.toLocalDate().toString(), subInfos));
            infos.add(cafeInfo);
        }

        return infos.build();
    }
}
