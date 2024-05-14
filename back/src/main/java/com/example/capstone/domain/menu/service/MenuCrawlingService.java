package com.example.capstone.domain.menu.service;

import com.example.capstone.global.error.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;

import static com.example.capstone.global.error.exception.ErrorCode.TEST_KEY_NOT_VALID;

@Service
@RequiredArgsConstructor
public class MenuCrawlingService {

    private final MenuUpdateService menuUpdateService;

    @Value("${test.key}")
    private String testKey;

    public boolean testKeyCheck(String key){
        if(key.equals(testKey)) return true;
        else throw new BusinessException(TEST_KEY_NOT_VALID);
    }

    @Scheduled(cron = "0 0 4 * * MON")
    public void crawlingMenus(){
        LocalDate startDay = LocalDate.now();

        for(int i=0; i<7; i++){
            menuUpdateService.updateMenus(startDay.plusDays(i));
        }
    }
}
