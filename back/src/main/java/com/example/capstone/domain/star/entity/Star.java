package com.example.capstone.domain.star.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "stars")
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Star {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "uuid", nullable = false)
    private String uuid;

    @Column(name = "answer_id", nullable = false)
    private Long answerId;

}
