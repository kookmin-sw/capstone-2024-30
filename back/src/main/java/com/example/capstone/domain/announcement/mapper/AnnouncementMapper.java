package com.example.capstone.domain.announcement.mapper;

import com.example.capstone.domain.announcement.dto.AnnouncementListResponse;
import com.example.capstone.domain.announcement.entity.Announcement;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface AnnouncementMapper {

    AnnouncementMapper INSTANCE = Mappers.getMapper(AnnouncementMapper.class);

    AnnouncementListResponse entityToResponse(Announcement announcement);
}
