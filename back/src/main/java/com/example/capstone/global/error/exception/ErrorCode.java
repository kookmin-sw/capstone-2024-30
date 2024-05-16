package com.example.capstone.global.error.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ErrorCode {

    // Common Error
    INVALID_INPUT_VALUE(400, "C001", "Invalid Input Value"),
    METHOD_NOT_ALLOWED(405, "C002", "Method Not Allowed"),
    ENTITY_NOT_FOUND(400, "C003", "Entity Not Found"),
    INTERNAL_SERVER_ERROR(500, "C004", "Server Error"),
    INVALID_TYPE_VALUE(400, "C005", "Invalid Type Value"),
    HANDLE_ACCESS_DENIED(403, "C006", "Access is Denied"),

    // JWT Error
    INVALID_JWT_TOKEN(401, "J001", "Invalid JWT Token"),
    NOT_EXIST_REFRESH_TOKEN(401, "J002", "Not Existing Refresh Token"),

    // User Error
    ALREADY_EMAIL_EXIST(400, "U001", "Already email exists"),
    USER_NOT_FOUND(400, "U002", "User Not Found"),

    // Database Error
    REDIS_CONNECTION_FAIL(400, "D001", "Redis Connection Failed"),

    // Crawling Error
    Crawling_FAIL(400, "CR001", "Crawling Failed"),

    // TestKey Error
    TEST_KEY_NOT_VALID(403, "T001", "Test Key is not valid"),

    // S3 Error
    EMPTY_FILE_EXCEPTION(400, "S301", "File is empty"),
    IO_EXCEPTION_ON_IMAGE_UPLOAD(400, "S302", "Io exception on image"),
    NO_FILE_EXTENSION(400, "S303", "Not found file"),
    INVALID_FILE_EXTENSION(400, "S304", "File is invalid"),
    PUT_OBJECT_EXCEPTION(400, "S305", "Object can not put"),
    IO_EXCEPTION_ON_IMAGE_DELETE(400, "S306", "Io exception on image delete"),
    MAX_SIZE_UPLOAD_EXCEED(400, "S307", "File size exceeded the max size"),

    // HMAC
    HMAC_NOT_VALID(403, "HM001", "HMAC is not valid"),

    // Search Error
    SEARCH_TOO_SHORT(400, "S001", "Search key word is too short")
    ;

    private int status;
    private final String code;
    private final String message;
}
