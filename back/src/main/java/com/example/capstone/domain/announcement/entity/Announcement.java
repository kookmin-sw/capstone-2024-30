package com.example.capstone.domain.announcement.entity;

import com.example.capstone.global.entity.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "announcements")
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Announcement extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "announcement_id")
    private Long id;

    @Column(nullable = false)
    private String type;

    @Column(nullable = false)
    private String title;

    @Column(name = "written_date", nullable = false)
    private LocalDate writtenDate;

    @Column
    private String department;

    @Column
    private String author;

    @Column(name = "author_phone")
    private String authorPhone;

    @Column(columnDefinition = "LONGTEXT", nullable = false)
    private String document;

    @Column(nullable = false)
    private String language;

    @Column(nullable = false)
    private String url;

    @OneToMany(mappedBy = "announcement", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<AnnouncementFile> files;

    public void setFiles(List<AnnouncementFile> files){
        if(files != null){
            this.files.clear();
            this.files.addAll(files);
        }
    }
}
