package com.example.capstone.domain.menu.repository;

import com.example.capstone.domain.menu.entity.Menu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Repository
public interface MenuRepository extends JpaRepository<Menu, Long> {
    Menu save(Menu menu);

    @Query("SELECT m FROM Menu m " +
            "WHERE m.date = :menuDate " +
            "AND m.cafeteria = :cafe " +
            "AND m.language = :lang")
    List<Menu> findMenuByDateAndCafeteria(@Param("menuDate") LocalDateTime date, @Param("cafe") String cafe, @Param("lang") String lang);

    @Query("SELECT DISTINCT m.cafeteria FROM Menu m " +
            "WHERE m.date = :menuDate " +
            "AND m.language = :lang")
    List<String> findMenuCafeByDateAndLang(@Param("menuDate") LocalDateTime date, @Param("lang") String lang);
}
