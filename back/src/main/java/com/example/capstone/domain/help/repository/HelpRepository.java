package com.example.capstone.domain.help.repository;

import com.example.capstone.domain.help.entity.Help;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface HelpRepository extends JpaRepository<Help, Long>, HelpListRepository {

    Help save(Help help);

    Optional<Help> findById(Long id);

    void deleteById(Long id);
}
