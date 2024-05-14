package com.example.capstone.domain.like.repository;

import com.example.capstone.domain.like.entity.Like;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeRepository extends JpaRepository<Like, Long>, LikeCustomRepository {
    Like save(Like like);
}
