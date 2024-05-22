package com.example.capstone.domain.announcement.service;

import com.deepl.api.DeepLException;
import com.deepl.api.TextTranslationOptions;
import com.deepl.api.Translator;
import com.example.capstone.domain.announcement.entity.Announcement;
import com.example.capstone.domain.announcement.entity.AnnouncementFile;
import com.example.capstone.domain.announcement.repository.AnnouncementRepository;
import com.example.capstone.global.error.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static com.example.capstone.global.error.exception.ErrorCode.Crawling_FAIL;
import static com.example.capstone.global.error.exception.ErrorCode.REDIS_CONNECTION_FAIL;

@Slf4j
@Service
@RequiredArgsConstructor
public class AnnouncementCrawlService {
    @Value("${deepl.api.key}")
    private String authKey;

    private final AnnouncementRepository announcementRepository;

    private final List<String> languages = List.of("KO", "EN-US", "ZH");

    @Async
    @Transactional
    public void crawlKookminAnnouncement(AnnouncementUrl url) {
        try {
            Document doc = Jsoup.connect(url.getUrl()).get();
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

            String baseUrl = "https://www.kookmin.ac.kr/";

            for (String link : links) {
                doc = Jsoup.connect(baseUrl + link).timeout(20000).get();

                String type = doc.select("h2.section_tit").text();

                Element element = doc.selectFirst(".view_tit");
                String title = element != null ? element.text() : "Default Title";

                Elements spans = doc.select(".board_etc > span");
                String writeDate = spans.get(0).text().split(" ")[1];
                String department = spans.get(1).text().split(" ")[1];
                String author = spans.get(2).text().split(" ")[1];
                Element phoneElement = doc.select("em").first();
                String authorPhone = (phoneElement != null) ? phoneElement.text().replace("☎ ", "") : "No Phone";
                Elements fileInfo = doc.select("div.board_atc.file > ul > li > a");
                String html = doc.select(".view_inner").outerHtml();

                Translator translator = new Translator(authKey);

                for (String language : languages) {
                    String translatedTitle = title;
                    String translatedDepartment = department;

                    if (!language.equals("KO")) {
                        translatedTitle = translator.translateText(title, "KO", language).getText();
                        translatedDepartment = translator.translateText(department, "KO", language).getText();
                    }

                    Optional<Announcement> check = announcementRepository.findByTitle(translatedTitle);
                    if (!check.isEmpty()) continue;

                    String document = html;
                    if (!language.equals("KO")) {
                        document = translateRecursive(html, language, 1, translator);
                        if(!StringUtils.hasText(document)) document = html;
                    }

                    List<AnnouncementFile> files = new ArrayList<>();
//                    System.out.println(fileInfo.size());
//                    for (Element file : fileInfo){
//                        String fileUrl = file.attr("href");
//                        String fileTitle = file.text();
//                        if(!language.equals("KO")){
//                            fileTitle = translator.translateText(fileTitle, "KO", language).getText();
//                        }
//                        System.out.println(fileUrl + ", " + fileTitle);
//                        AnnouncementFile announcementFile = AnnouncementFile.builder()
//                                .link(fileUrl)
//                                .title(fileTitle)
//                                .build();
//                        files.add(announcementFile);
//                    }

                    Announcement announcement = Announcement.builder()
                            .type(type)
                            .title(translatedTitle)
                            .author(author)
                            .authorPhone(authorPhone)
                            .department(translatedDepartment)
                            .writtenDate(LocalDate.parse(writeDate, formatter))
                            .document(document)
                            .language(language)
                            .files(files)
                            .url(baseUrl + link)
                            .build();

                    announcementRepository.save(announcement);
                }
            }
        } catch (Exception e) {
            System.out.println(e);
            throw new BusinessException(Crawling_FAIL);
        }
    }

    @Async
    @Transactional
    public void crawlInternationlAnnouncement(AnnouncementUrl url) {
        try {
            Document doc = Jsoup.connect(url.getUrl()).get();
            Elements announcements = doc.select("table.board-table tbody tr");
            ArrayList<String> links = new ArrayList<>();

            LocalDate currentDate = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy.MM.dd");

            for (Element announcement : announcements) {
                Elements dateElements = announcement.select("span.b-date");
                if (!dateElements.isEmpty()) {
                    String dateStr = dateElements.text();
                    LocalDate noticeDate = LocalDate.parse(dateStr, formatter);

                    if (noticeDate.isAfter(currentDate.minusDays(1))) {
                        Elements linkElements = announcement.select("td.b-td-left a");
                        if (!linkElements.isEmpty()) {
                            String href = linkElements.attr("href");
                            if (links.contains(href)) continue;
                            links.add(href);
                            System.out.println(href);
                        }
                    }
                }
            }

            String baseUrl = url.getUrl();
            Translator translator = new Translator(authKey);

            for (String link : links) {
                doc = Jsoup.connect(baseUrl + link).timeout(20000).get();

                Element element = doc.selectFirst("span.b-title");
                String title = element != null ? element.text() : "Default Title";

                Elements spans = doc.select("li.b-writer-box > span");
                String author = spans.get(0).text();
                spans = doc.select("li.b-date-box > span");
                String writeDate = spans.get(0).text();
                String department = "외국인유학생지원센터";
                String authorPhone = "02-910-5808";

                Elements images = doc.select("img[src]");
                for (Element img : images) {
                    String src = img.attr("src");
                    if (!src.startsWith("http://") && !src.startsWith("https://")) {
                        img.attr("src", "https://cms.kookmin.ac.kr" + src);
                    }
                }

                String html = doc.select(".b-content-box").outerHtml();

                for (String language : languages) {
                    String translatedTitle = title;
                    String translatedDepartment = department;

                    if (!language.equals("KO")) {
                        translatedTitle = translator.translateText(title, "KO", language).getText();
                        translatedDepartment = translator.translateText(department, "KO", language).getText();
                    }

                    Optional<Announcement> check = announcementRepository.findByTitle(translatedTitle);
                    if (!check.isEmpty()) continue;

                    String document = html;
                    if (!language.equals("KO")) {
                        document = translateRecursive(html, language, 1, translator);
                        if(!StringUtils.hasText(document)) document = html;
                    }

                    List<AnnouncementFile> files = new ArrayList<>();
                    formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

                    Announcement announcement = Announcement.builder()
                            .type(url.getType())
                            .title(translatedTitle)
                            .author(author)
                            .authorPhone(authorPhone)
                            .department(translatedDepartment)
                            .writtenDate(LocalDate.parse(writeDate, formatter))
                            .document(document)
                            .language(language)
                            .url(baseUrl + link)
                            .files(files)
                            .build();

                    announcementRepository.save(announcement);
                }
            }
        } catch (Exception e) {
            System.out.println(e);
            throw new BusinessException(Crawling_FAIL);
        }
    }

    @Async
    @Transactional
    public void crawlSoftwareAnnouncement(AnnouncementUrl url) {
        try {
            Document doc = Jsoup.connect(url.getUrl()).get();
            Elements announcements = doc.select(".list-tbody > ul");
            ArrayList<String> links = new ArrayList<>();

            LocalDate currentDate = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy.MM.dd");

            for (Element announcement : announcements) {
                String dateStr = announcement.select(".date").text();
                LocalDate noticeDate = LocalDate.parse(dateStr, formatter);

                if (noticeDate.equals(currentDate)) {
                    String href = announcement.select(".subject > a").attr("href");
                    links.add(href.substring(1, href.length()));
                }
            }

            String baseUrl = url.getUrl();
            Translator translator = new Translator(authKey);

            for (String link : links) {
                doc = Jsoup.connect(baseUrl + link).timeout(20000).get();

                String title = doc.select(".view-title").text();
                String author = doc.select("th:contains(작성자) + td").text();
                String writeDate = doc.select("th.aricle-subject + td").text();
                String department = "소프트웨어융합대학";
                String authorPhone = "02-910-6642";

                Elements images = doc.select("img[src]");
                for (Element img : images) {
                    String src = img.attr("src");
                    if (!src.startsWith("http:") && !src.startsWith("https:")) {
                        img.attr("src", "https:" + src);
                    }
                }

                String html = doc.select(".board.board-view #view-detail-data").first().outerHtml();

                for (String language : languages) {
                    String translatedTitle = title;
                    String translatedDepartment = department;

                    if (!language.equals("KO")) {
                        translatedTitle = translator.translateText(title, "KO", language).getText();
                        translatedDepartment = translator.translateText(department, "KO", language).getText();
                    }

                    Optional<Announcement> check = announcementRepository.findByTitle(translatedTitle);
                    if (!check.isEmpty()) continue;

                    String document = html;
                    if (!language.equals("KO")) {
                        document = translateRecursive(html, language, 1, translator);
                        if(!StringUtils.hasText(document)) document = html;
                    }

                    List<AnnouncementFile> files = new ArrayList<>();
                    formatter = DateTimeFormatter.ofPattern("yy.MM.dd");

                    Announcement announcement = Announcement.builder()
                            .type(url.getType())
                            .title(translatedTitle)
                            .author(author)
                            .authorPhone(authorPhone)
                            .department(translatedDepartment)
                            .writtenDate(LocalDate.parse(writeDate, formatter))
                            .document(document)
                            .language(language)
                            .url(baseUrl.substring(0, baseUrl.length()-1) + link)
                            .files(files)
                            .build();

                    announcementRepository.save(announcement);
                }
            }
        } catch (Exception e) {
            System.out.println(e);
            throw new BusinessException(Crawling_FAIL);
        }
    }

    private String translateRecursive(String html, String language, int part, Translator translator){
        if(part == 11) return "";

        String document = "";
        try {
            List<String> list = new ArrayList<>();
            list.add(html);
            if(part != 1) list = splitHtml(html, part);
            for(int i = 0; i<list.size(); i++){
                TextTranslationOptions options = new TextTranslationOptions().setTagHandling("html");
                document += translator.translateText(html, "KO", language, options).getText();
            }
        } catch (DeepLException | InterruptedException e) {
            log.error("DeepL Too Large for " + part + " part");
            translateRecursive(html, language, part+1, translator);
        }
        return document;
    }

    private List<String> splitHtml(String html, int part){
        List<String> list = new ArrayList<>();
        int len = html.length() / part;
        int lastIdx = 0;

        for(int i = 0; i<part-1; i++){
            int endIdx = findNextPoint(html, lastIdx + len);
            if(endIdx == -1) break;
            list.add(html.substring(lastIdx, endIdx));
            lastIdx = endIdx;
        }

        return list;
    }

    private static int findNextPoint(String html, int start) {
        int nextSplitPoint = html.indexOf('>', start);
        return nextSplitPoint == -1 ? -1 : nextSplitPoint + 1;
    }
}
