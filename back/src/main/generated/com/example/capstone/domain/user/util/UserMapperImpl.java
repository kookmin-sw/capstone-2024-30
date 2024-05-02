package com.example.capstone.domain.user.util;

import com.example.capstone.domain.jwt.PrincipalDetails;
import com.example.capstone.domain.user.dto.SignupRequest;
import com.example.capstone.domain.user.entity.User;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-04-30T01:59:17+0900",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 17.0.9 (JetBrains s.r.o.)"
)
public class UserMapperImpl implements UserMapper {

    @Override
    public User signupReqeustToUser(SignupRequest request) {
        if ( request == null ) {
            return null;
        }

        User.UserBuilder user = User.builder();

        user.id( request.uuid() );
        user.email( request.email() );
        user.major( request.major() );
        user.country( request.country() );
        user.name( request.name() );
        user.phoneNumber( request.phoneNumber() );

        return user.build();
    }

    @Override
    public User principalDetailsToUser(PrincipalDetails principalDetails) {
        if ( principalDetails == null ) {
            return null;
        }

        User.UserBuilder user = User.builder();

        user.id( principalDetails.getUuid() );
        user.email( principalDetails.getEmail() );
        user.major( principalDetails.getMajor() );
        user.country( principalDetails.getCountry() );
        user.name( principalDetails.getName() );
        user.phoneNumber( principalDetails.getPhoneNumber() );

        return user.build();
    }
}
