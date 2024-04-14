package com.example.capstone.domain.announcement.repository;

import com.example.capstone.domain.announcement.entity.Announcement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AnnouncementRepository extends JpaRepository<Announcement, Long> {
    Optional<Announcement> findByTitle(String title);
}
