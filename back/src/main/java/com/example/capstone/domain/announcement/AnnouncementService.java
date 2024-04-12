package com.example.capstone.domain.announcement;

import com.deepl.api.Translator;
import com.example.capstone.global.error.exception.BusinessException;
import com.example.capstone.global.error.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AnnouncementService {
    @Value("${deepl.api.key}")
    private String authKey;


    private String[] urlList = {
            "https://www.kookmin.ac.kr/user/kmuNews/notice/index.do"
    };

    @Scheduled(cron = "0 0 0 * * *")
    public void crawlingAnnouncement(){
        getAnnouncementList(urlList[0]);
    }

    public void getAnnouncementList(String url){
        try{
            Document doc = Jsoup.connect(url).get();
            Elements announcements = doc.select("div.board_list > ul > li > a");
            ArrayList<String> links = new ArrayList<>();

            LocalDate currentDate = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");


            for (Element announcement : announcements) {
                String dateStr = announcement.select(".board_etc > span").first().text();
                LocalDate noticeDate = LocalDate.parse(dateStr, formatter);

                if (noticeDate.equals(currentDate)) {
                    String href = announcement.attr("href");
                    links.add(href);
                }
            }

            for(String link : links){
                doc = Jsoup.connect(url).get();

                Element element = doc.selectFirst(".view_tit");
                String text = element.text();

                Translator translator = new Translator(authKey);
                List<String> languages = List.of("KO", "EN-US");


                System.out.println(link);
            }
        }
        catch (Exception e){
            System.out.println(e);
            throw new BusinessException(ErrorCode.REDIS_CONNECTION_FAIL);
        }
    }
}
