package com.example.capstone.domain.menu.service;

import com.example.capstone.domain.menu.entity.Menu;
import com.example.capstone.domain.menu.repository.MenuRepository;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.deepl.api.*;
import jakarta.json.*;
import jakarta.json.stream.JsonGenerator;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.StringReader;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
@RequiredArgsConstructor
public class MenuService {

    private final MenuUpdateService menuUpdateService;

    @Scheduled(cron = "0 0 4 * * MON")
    public void crawlingMenu(){
        LocalDateTime startDay = LocalDateTime.now();

        for(int i=0; i<7; i++){
            menuUpdateService.updateMenus(startDay.plusDays(i));
        }
    }
}
