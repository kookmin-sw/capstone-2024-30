package com.example.capstone.domain.user.entity;

import com.example.capstone.global.entity.BaseTimeEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User extends BaseTimeEntity {
    @Id
    @Column(name = "user_id")
    private String id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String bigmajor;

    @Column(nullable = false)
    private String major;

    @Column(nullable = false)
    private String country;

    @Column(nullable = false)
    private String name;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Builder.Default
    private String role = "ROLE_USER";

    public void updateProfile(String name, String major, String country, String phoneNumber) {
        this.name = name;
        this.major = major;
        this.country = country;
        this.phoneNumber = phoneNumber;
    }

    public void setId(String id) {
        this.id = id;
    }
}
