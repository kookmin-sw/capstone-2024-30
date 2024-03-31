package com.example.capstone.domain.menu.repository;

import com.example.capstone.domain.menu.entity.Menu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface MenuRepository extends JpaRepository<Menu, Long> {
    Menu save(Menu menu);

    @Query("SELECT m FROM Menu m " +
            "WHERE m.date = :menuDate " +
            "AND m.cafeteria = :cafe")
    List<Menu> findMenuByDateAndCafeteria(@Param("menuDate") LocalDateTime date, @Param("cafe") String cafe);

}
