package com.example.capstone.domain.speech.service;

import com.microsoft.cognitiveservices.speech.*;
import com.microsoft.cognitiveservices.speech.audio.AudioConfig;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

@Service
public class SpeechService {
    private String speechKey = "";
    private String speechRegion = "";

    public void test() throws InterruptedException, ExecutionException, TimeoutException {
        SpeechConfig speechConfig = SpeechConfig.fromSubscription(speechKey, speechRegion);
        speechConfig.setSpeechRecognitionLanguage("ko-KR");
        testFromFile(speechConfig);
    }

    public void testFromFile(SpeechConfig speechConfig) throws InterruptedException, ExecutionException, TimeoutException {
        AudioConfig audioConfig = AudioConfig.fromWavFileInput("");
        SpeechRecognizer speechRecognizer = new SpeechRecognizer(speechConfig, audioConfig);

        PronunciationAssessmentConfig pronunciationConfig = new PronunciationAssessmentConfig("",  PronunciationAssessmentGradingSystem.HundredMark, PronunciationAssessmentGranularity.Phoneme, false);

        pronunciationConfig.applyTo(speechRecognizer);
        Future<SpeechRecognitionResult> future = speechRecognizer.recognizeOnceAsync();
        SpeechRecognitionResult speechRecognitionResult = future.get(30, TimeUnit.SECONDS);

        PronunciationAssessmentResult pronunciationAssessmentResult =
                PronunciationAssessmentResult.fromResult(speechRecognitionResult);

        String pronunciationAssessmentResultJson = speechRecognitionResult.getProperties().getProperty(PropertyId.SpeechServiceResponse_JsonResult);

        System.out.println(pronunciationAssessmentResultJson);

        speechRecognizer.close();
        speechConfig.close();
        audioConfig.close();
        pronunciationConfig.close();
        speechRecognitionResult.close();
    }

}
