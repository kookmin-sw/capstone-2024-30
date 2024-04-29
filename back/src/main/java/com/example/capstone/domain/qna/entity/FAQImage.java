package com.example.capstone.domain.qna.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "faq_images")
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FAQImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "faq_id")
    private FAQ faqId;

    @Column(name = "url", nullable = false)
    private String url;
}
