package com.example.capstone.domain.qna.entity;

import com.example.capstone.domain.user.entity.User;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "questions")
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "author", nullable = false)
    private String author;

    @Column(name = "context", columnDefinition = "LONGTEXT", nullable = false)
    private String context;

    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate;

    @Column(name = "updated_date", nullable = false)
    private LocalDateTime updatedDate;

    @Column(name = "view", nullable = false)
    private Long view;

    @Column(name = "uuid", nullable = false)
    private UUID uuid;

    public void update(String title, String context, LocalDateTime updatedDate){
        this.title = title;
        this.context = context;
        this.updatedDate = updatedDate;
    }
}
