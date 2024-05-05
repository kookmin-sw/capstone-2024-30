package com.example.capstone.domain.help.entity;

import com.example.capstone.domain.help.dto.HelpResponse;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "helps")
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Help {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "is_done", nullable = false)
    private boolean isDone;

    @Column(name = "is_helper", nullable = false)
    private boolean isHelper;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "context", columnDefinition = "LONGTEXT", nullable = false)
    private String context;

    @Column(name = "author", nullable = false)
    private String author;

    @Column(name = "country", nullable = false)
    private String country;

    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate;

    @Column(name = "updated_date", nullable = false)
    private LocalDateTime updatedDate;

    @Column(name = "uuid", nullable = false, unique = true)
    private String uuid;

    public void update(String title, String context, LocalDateTime updatedDate) {
        this.title = title;
        this.context = context;
        this.updatedDate = updatedDate;
    }

    public void done() {
        isDone = true;
    }

    public HelpResponse toDTO() {
        return new HelpResponse(id, isDone, isHelper, title, context, author, country, createdDate, updatedDate,uuid);
    }
}
