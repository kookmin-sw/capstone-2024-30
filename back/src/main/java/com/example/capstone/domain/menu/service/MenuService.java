package com.example.capstone.domain.menu.service;

import com.example.capstone.domain.menu.entity.Menu;
import com.example.capstone.domain.menu.repository.MenuRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.deepl.api.*;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.hibernate.cfg.Environment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
@RequiredArgsConstructor
public class MenuService {
    private final MenuRepository menuRepository;
    private final String authKey = "";

    public void addMenus(LocalDateTime startTime) {
        RestTemplate restTemplate = new RestTemplateBuilder().build();
        String sdate = startTime.format(DateTimeFormatter.ISO_LOCAL_DATE);
        String url = "https://kmucoop.kookmin.ac.kr/menu/menujson.php?callback=jQuery112401919322099601417_1711424604017";

        url += "&sdate=" + sdate + "&edate=" + sdate + "&today=" + sdate + "&_=1711424604018";
        String escapeString = restTemplate.getForObject(url, String.class);
        String response = decodeUnicode(escapeString);

        Translator translator = new Translator(authKey);
        List<String> languages = List.of("KO", "EN-US");

        try {
            for(String language : languages) {
                String json = response.substring(response.indexOf("(") + 1, response.lastIndexOf(")"));
                ObjectMapper mapper = new ObjectMapper();
                Map<String, Object> allMap = mapper.readValue(json, Map.class);

                for (Map.Entry<String, Object> cafeEntry : allMap.entrySet()) {
                    String cafeteria = translator.translateText(cafeEntry.getKey(), null, language).getText();

                    for (Map.Entry<String, Object> dateEntry : ((Map<String, Object>) cafeEntry.getValue()).entrySet()) {
                        String dateString = dateEntry.getKey();
                        LocalDateTime date = LocalDate.parse(dateString, DateTimeFormatter.ISO_LOCAL_DATE).atStartOfDay();

                        for (Map.Entry<String, Object> sectionEntry : ((Map<String, Object>) dateEntry.getValue()).entrySet()) {
                            String section = translator.translateText(sectionEntry.getKey(), null, language).getText();
                            String name = "";
                            Long price = 0L;

                            for (Map.Entry<String, Object> context : ((Map<String, Object>) sectionEntry.getValue()).entrySet()) {
                                if (context.getKey().equals("메뉴") && context.getValue().equals("") == false) {
                                    name = translator.translateText(context.getValue().toString(), null, language).getText();
                                } else if (context.getKey().equals("가격")) {
                                    price = NumberUtils.toLong(context.getValue().toString());
                                }
                            }
                            if (name.equals("") == false) {
                                menuRepository.save(Menu.builder().cafeteria(cafeteria).section(section).date(date).name(name).price(price).language(language).build());
                            }
                        }
                    }
                }
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String findMenuByDate(LocalDateTime dateTime) {
        List<String> cafeList = List.of("한울식당(법학관 지하1층)", "학생식당(복지관 1층)",
                "교직원식당(복지관 1층)", "청향 한식당(법학관 5층)",
                "청향 양식당(법학관 5층)", "생활관식당 일반식(생활관 A동 1층)");
        List<String> infos = new ArrayList<>();

        for(String cafe : cafeList) {
            List<Menu> menuList = menuRepository.findMenuByDateAndCafeteria(dateTime, cafe);
            List<String> subInfos = new ArrayList<>();

            for(Menu menu : menuList) {
                subInfos.add(Map.of("\"" + menu.getSection() + "\"", Map.of("\"메뉴\"", "\"" + menu.getName() + "\"", "\"가격\"", "\"" + menu.getPrice() + "\"")).toString());
            }

            infos.add(Map.of("\"" + cafe + "\"", Map.of("\"" + dateTime.toLocalDate() + "\"", subInfos.toString())).toString());
        }

        System.out.println(infos);
        return infos.toString().replaceAll("=", ":").replaceAll("\\[|\\]", "");
    }

    private String decodeUnicode(String str){
        StringBuilder builder = new StringBuilder();
        int i = 0;
        while(i < str.length()) {
            char ch = str.charAt(i);
            if(ch == '\\' && i + 1 < str.length() && str.charAt(i + 1) == 'u') {
                int codePoint = Integer.parseInt(str.substring(i + 2, i + 6), 16);
                builder.append(Character.toChars(codePoint));
                i += 6;
            }
            else {
                builder.append(ch);
                i++;
            }
        }
        return builder.toString();
    }
}
