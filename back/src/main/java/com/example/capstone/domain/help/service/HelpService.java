package com.example.capstone.domain.help.service;

import com.example.capstone.domain.help.dto.*;
import com.example.capstone.domain.help.repository.HelpListRepository;
import com.example.capstone.domain.help.repository.HelpRepository;
import com.example.capstone.domain.help.entity.Help;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class HelpService {
    private final HelpRepository helpRepository;

    public HelpResponse createHelp(String userId, HelpPostRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Help help = helpRepository.save(Help.builder().title(request.title()).context(request.context())
                .author(request.author()).createdDate(current).updatedDate(current).isHelper(request.isHelper())
                .isDone(false).country(request.country()).uuid(UUID.fromString(userId)).build());

        return help.toDTO();
    }

    public HelpResponse getHelp(Long id) {
        Help help = helpRepository.findById(id).get();
        return help.toDTO();
    }

    @Transactional
    public void updateHelp(String userId, HelpPutRequest request) {
        LocalDateTime current = LocalDateTime.now();
        Help help = helpRepository.findById(request.id()).get();
        help.update(request.title(), request.context(), current);
    }

    public void eraseHelp(Long id){
        helpRepository.deleteById(id);
    }


}
