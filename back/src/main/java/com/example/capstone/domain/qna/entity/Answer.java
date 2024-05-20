package com.example.capstone.domain.qna.entity;

import com.example.capstone.domain.qna.dto.AnswerResponse;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

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

    @Column(name = "uuid", nullable = false)
    private String uuid;

    public void update(String context, LocalDateTime updatedDate) {
        this.context = context;
        this.updatedDate = updatedDate;
    }

    public void updateLikeCount(Long count) {
        likeCount = count;
    }

    public AnswerResponse toDTO() {
        return new AnswerResponse(id, question.getId(), author, context, likeCount, createdDate, updatedDate, uuid);
    }
}