package com.example.capstone.domain.menu.service;

import com.deepl.api.Translator;
import com.example.capstone.domain.menu.entity.Menu;
import com.example.capstone.domain.menu.repository.MenuRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
public class MenuUpdateService {
    private final MenuRepository menuRepository;
    private final DecodeUnicodeService decodeUnicodeService;

    @Value("${deepl.api.key}")
    private String authKey;
    List<String> languages = List.of("KO", "EN-US", "ZH");

    @Async
    @Transactional
    public void updateMenus(LocalDate startTime) {
        RestTemplate restTemplate = new RestTemplateBuilder().build();
        String sdate = startTime.toString();
        String url = "https://kmucoop.kookmin.ac.kr/menu/menujson.php?callback=jQuery112401919322099601417_1711424604017";

        url += "&sdate=" + sdate + "&edate=" + sdate + "&today=" + sdate + "&_=1711424604018";
        String escapeString = restTemplate.getForObject(url, String.class);
        CompletableFuture<String> decode = decodeUnicodeService.decodeUnicode(escapeString);

        Translator translator = new Translator(authKey);

        try {
            String response = decode.get();

            System.out.println(response);

            for(String language : languages) {
                String json = response.substring(response.indexOf("(") + 1, response.lastIndexOf(")"));
                ObjectMapper mapper = new ObjectMapper();
                Map<String, Object> allMap = mapper.readValue(json, Map.class);

                for (Map.Entry<String, Object> cafeEntry : allMap.entrySet()) {
                    if( (cafeEntry.getValue() instanceof Map) == false ) continue;

                    String cafeteria = translator.translateText(cafeEntry.getKey(), null, language).getText();

                    for (Map.Entry<String, Object> dateEntry : ((Map<String, Object>) cafeEntry.getValue()).entrySet()) {
                        if( (dateEntry.getValue() instanceof Map) == false ) continue;

                        String dateString = dateEntry.getKey();
                        LocalDateTime date = LocalDate.parse(dateString, DateTimeFormatter.ISO_LOCAL_DATE).atStartOfDay();

                        for (Map.Entry<String, Object> sectionEntry : ((Map<String, Object>) dateEntry.getValue()).entrySet()) {
                            if( (sectionEntry.getValue() instanceof Map) == false ) continue;

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
}