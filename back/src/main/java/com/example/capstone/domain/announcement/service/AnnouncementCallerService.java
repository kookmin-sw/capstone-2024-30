package com.example.capstone.domain.announcement.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.example.capstone.domain.announcement.service.AnnouncementUrl.*;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AnnouncementCallerService {
    private final AnnouncementCrawlService announcementCrawlService;

    @Scheduled(cron = "0 0 12,18 * * *")
    public void crawlingAnnouncement() {
        announcementCrawlService.crawlKookminAnnouncement(KOOKMIN_OFFICIAL);
        announcementCrawlService.crawlInternationlAnnouncement(INTERNATIONAL_ACADEMIC);
        announcementCrawlService.crawlKookminAnnouncement(INTERNATIONAL_VISA);
        announcementCrawlService.crawlInternationlAnnouncement(INTERNATIONAL_PROGRAM);
        announcementCrawlService.crawlInternationlAnnouncement(INTERNATIONAL_EVENT);
        announcementCrawlService.crawlInternationlAnnouncement(INTERNATIONAL_SCHOLARSHIP);
        announcementCrawlService.crawlInternationlAnnouncement(INTERNATIONAL_GKS);
        announcementCrawlService.crawlSoftwareAnnouncement(SOFTWARE_ACADEMIC);
        announcementCrawlService.crawlSoftwareAnnouncement(SOFTWARE_JOB);
        announcementCrawlService.crawlSoftwareAnnouncement(SOFTWARE_EVENT);
        announcementCrawlService.crawlSoftwareAnnouncement(SOFTWARE_SCHOLARSHIP);
    }
}
