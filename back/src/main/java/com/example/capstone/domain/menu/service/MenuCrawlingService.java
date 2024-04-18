package com.example.capstone.domain.menu.service;

import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class MenuCrawlingService {

    private final MenuUpdateService menuUpdateService;

    @Scheduled(cron = "0 0 4 * * MON")
    public void crawlingMenus(){
        LocalDateTime startDay = LocalDateTime.now();

        for(int i=0; i<7; i++){
            menuUpdateService.updateMenus(startDay.plusDays(i));
        }
    }
}
