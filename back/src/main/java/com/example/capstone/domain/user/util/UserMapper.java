package com.example.capstone.domain.user.util;

import com.example.capstone.domain.auth.dto.SignupRequest;
import com.example.capstone.domain.user.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    @Mapping(target = "id", source = "uuid")
    User signupReqeustToUser(SignupRequest request);
}
