package com.example.capstone.domain.star.repository;

import com.example.capstone.domain.star.entity.Star;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface StarRepository extends JpaRepository<Star, Long>, StarCustomRepository {
    Star save(Star star);
}
