package com.example.capstone.domain.qna.entity;

import com.example.capstone.domain.qna.dto.AnswerResponse;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "answers")
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Answer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id")
    private Question question;

    @Column(name = "author", nullable = false)
    private String author;

    @Column(name = "context", columnDefinition = "LONGTEXT", nullable = false)
    private String context;

    @Column(name = "like_count", nullable = false)
    private Long likeCount;

    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate;

    @Column(name = "updated_date", nullable = false)
    private LocalDateTime updatedDate;

    @Column(name = "uuid", nullable = false, unique = true)
    private UUID uuid;


}