package com.example.capstone.domain.user.util;

import com.example.capstone.domain.jwt.PrincipalDetails;
import com.example.capstone.domain.user.dto.SignupRequest;
import com.example.capstone.domain.user.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    @Mapping(target = "id", source = "uuid")
    @Mapping(target = "role", ignore = true)
    @Mapping(target = "createDate", ignore = true)
    @Mapping(target = "updateAt", ignore = true)
    User signupReqeustToUser(SignupRequest request);

    @Mapping(target = "id", source = "uuid")
    @Mapping(target = "role", ignore = true)
    @Mapping(target = "createDate", ignore = true)
    @Mapping(target = "updateAt", ignore = true)
    User principalDetailsToUser(PrincipalDetails principalDetails);
}
