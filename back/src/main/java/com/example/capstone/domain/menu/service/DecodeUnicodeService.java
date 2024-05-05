package com.example.capstone.domain.menu.service;

import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
public class DecodeUnicodeService {

    @Async
    public CompletableFuture<String> decodeUnicode(String str) {
        StringBuilder builder = new StringBuilder();
        int i = 0;
        while(i < str.length()) {
            char ch = str.charAt(i);
            if(ch == '\\' && i + 1 < str.length() && str.charAt(i + 1) == 'u') {
                int codePoint = Integer.parseInt(str.substring(i + 2, i + 6), 16);
                builder.append(Character.toChars(codePoint));
                i += 6;
            }
            else {
                builder.append(ch);
                i++;
            }
        }
        return CompletableFuture.completedFuture(builder.toString());
    }
}
