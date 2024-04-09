package com.example.capstone.domain.announcement;

import com.example.capstone.global.error.exception.BusinessException;
import com.example.capstone.global.error.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

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

    public void crawlingAnnouncement(){
        getAnnouncementList(urlList[0]);
    }

    public void getAnnouncementList(String url){
        try{
            Document doc = Jsoup.connect(url).get();
            Elements announcements = doc.select("div.board_list a");
            ArrayList<String> links = new ArrayList<>();
            for (Element announcement : announcements) {
                String absoluteUrl = announcement.attr("abs:href");
                links.add(absoluteUrl);
            }

            for(String link : links){
                doc = Jsoup.connect(url).get();

            }
        }
        catch (Exception e){
            System.out.println(e);
            throw new BusinessException(ErrorCode.REDIS_CONNECTION_FAIL);
        }
    }
}
