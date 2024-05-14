package com.example.capstone.domain.like.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "likes")
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Like {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "uuid", nullable = false)
    private String uuid;

    @Column(name = "answer_id", nullable = false)
    private Long answerId;

    @Column(name = "is_click", nullable = false)
    private Boolean isClick;

    public void updateClick() {
        isClick = !isClick;
    }

}
