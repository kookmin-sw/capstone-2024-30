package com.example.capstone.domain.qna.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "question_images")
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class QuestionImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id")
    private Question questionId;

    @Column(name = "url", nullable = false)
    private String url;
}
