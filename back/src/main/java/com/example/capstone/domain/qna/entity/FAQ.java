package com.example.capstone.domain.qna.entity;

import com.example.capstone.domain.qna.dto.FAQResponse;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "faqs")
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FAQ {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "author", nullable = false)
    private String author;

    @Column(name = "question", columnDefinition = "LONGTEXT", nullable = false)
    private String question;

    @Column(name = "answer", columnDefinition = "LONGTEXT", nullable = false)
    private String answer;

    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate;

    @Column(name = "updated_date", nullable = false)
    private LocalDateTime updatedDate;

    @Column(name = "tag", nullable = false)
    private String tag;

    @Column(name = "language", nullable = false)
    private String language;

    public void update(String title, String question, String answer, LocalDateTime updatedDate) {
        this.title = title;
        this.question = question;
        this.answer = answer;
        this.updatedDate = updatedDate;
    }

    public FAQResponse toDTO() {
        return new FAQResponse(id, title, author, question, answer, createdDate, updatedDate, tag, language);
    }
}
