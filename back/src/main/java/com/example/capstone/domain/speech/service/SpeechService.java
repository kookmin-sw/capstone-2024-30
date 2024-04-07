package com.example.capstone.domain.speech.service;

import com.microsoft.cognitiveservices.speech.*;
import com.microsoft.cognitiveservices.speech.audio.AudioConfig;
import com.github.difflib.DiffUtils;
import com.github.difflib.patch.AbstractDelta;
import com.github.difflib.patch.DeltaType;
import com.github.difflib.patch.Patch;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonObject;
import jakarta.json.JsonReader;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.*;

@Service
public class SpeechService {
    private String speechKey = "";
    private String speechRegion = "koreacentral";
    private String speechLang = "ko-KR";

    private Semaphore stopRecognitionSemaphore;
    public void pronunciation(String compareText) throws InterruptedException, ExecutionException {
        SpeechConfig speechConfig = SpeechConfig.fromSubscription(speechKey, speechRegion);
        AudioConfig audioConfig = AudioConfig.fromWavFileInput("음성 정보.wav");

        stopRecognitionSemaphore = new Semaphore(0);
        List<String> recognizedWords = new ArrayList<>();
        List<Word> pronWords = new ArrayList<>();
        List<Word> finalWords = new ArrayList<>();
        List<Double> fluencyScores = new ArrayList<>();
        List<Double> prosodyScores = new ArrayList<>();
        List<Long> durations = new ArrayList<>();

        SpeechRecognizer recognizer = new SpeechRecognizer(speechConfig, speechLang, audioConfig);
        {
            recognizer.recognized.addEventListener((s, e) -> {
                if (e.getResult().getReason() == ResultReason.RecognizedSpeech) {
                    System.out.println("RECOGNIZED: Text=" + e.getResult().getText());
                    PronunciationAssessmentResult pronResult = PronunciationAssessmentResult.fromResult(e.getResult());
                    System.out.println(
                            String.format(
                                    "    Accuracy score: %f, Prosody score: %f, Pronunciation score: %f, Completeness score : %f, FluencyScore: %f",
                                    pronResult.getAccuracyScore(), pronResult.getProsodyScore(), pronResult.getPronunciationScore(),
                                    pronResult.getCompletenessScore(), pronResult.getFluencyScore()));
                    fluencyScores.add(pronResult.getFluencyScore());
                    prosodyScores.add(pronResult.getProsodyScore());

                    String jString = e.getResult().getProperties().getProperty(PropertyId.SpeechServiceResponse_JsonResult);
                    JsonReader jsonReader = Json.createReader(new StringReader(jString));
                    JsonObject jsonObject = jsonReader.readObject();
                    jsonReader.close();

                    JsonArray nBestArray = jsonObject.getJsonArray("NBest");

                    for (int i = 0; i < nBestArray.size(); i++) {
                        JsonObject nBestItem = nBestArray.getJsonObject(i);

                        JsonArray wordsArray = nBestItem.getJsonArray("Words");
                        long durationSum = 0;

                        for (int j = 0; j < wordsArray.size(); j++) {
                            JsonObject wordItem = wordsArray.getJsonObject(j);
                            recognizedWords.add(wordItem.getString("Word"));
                            durationSum += wordItem.getJsonNumber("Duration").longValue();

                            JsonObject pronAssessment = wordItem.getJsonObject("PronunciationAssessment");
                            pronWords.add(new Word(wordItem.getString("Word"), pronAssessment.getString("ErrorType"), pronAssessment.getJsonNumber("AccuracyScore").doubleValue()));
                        }
                        durations.add(durationSum);
                    }
                }
                else if (e.getResult().getReason() == ResultReason.NoMatch) {
                    System.out.println("NOMATCH: Speech could not be recognized.");
                }
            });

            recognizer.canceled.addEventListener((s, e) -> {
                System.out.println("CANCELED: Reason=" + e.getReason());

                if (e.getReason() == CancellationReason.Error) {
                    System.out.println("CANCELED: ErrorCode=" + e.getErrorCode());
                    System.out.println("CANCELED: ErrorDetails=" + e.getErrorDetails());
                    System.out.println("CANCELED: Did you update the subscription info?");
                }

                stopRecognitionSemaphore.release();
            });

            recognizer.sessionStarted.addEventListener((s, e) -> {
                System.out.println("\n    Session started event.");
            });

            recognizer.sessionStopped.addEventListener((s, e) -> {
                System.out.println("\n    Session stopped event.");
            });

            boolean enableMiscue = true;
            // The reference matches the input wave named YourAudioFile.wav.
            String referenceText = compareText;

            // Create pronunciation assessment config, set grading system, granularity and if enable miscue based on your requirement.
            PronunciationAssessmentConfig pronunciationConfig = new PronunciationAssessmentConfig(referenceText,
                    PronunciationAssessmentGradingSystem.HundredMark, PronunciationAssessmentGranularity.Phoneme, enableMiscue);

            pronunciationConfig.enableProsodyAssessment();

            pronunciationConfig.applyTo(recognizer);

            // Starts continuous recognition. Uses stopContinuousRecognitionAsync() to stop recognition.
            recognizer.startContinuousRecognitionAsync().get();

            // Waits for completion.
            stopRecognitionSemaphore.acquire();

            recognizer.stopContinuousRecognitionAsync().get();

            // For continuous pronunciation assessment mode, the service won't return the words with `Insertion` or `Omission`
            // even if miscue is enabled.
            // We need to compare with the reference text after received all recognized words to get these error words.
            String[] referenceWords = referenceText.toLowerCase().split(" ");
            for (int j = 0; j < referenceWords.length; j++) {
                referenceWords[j] = referenceWords[j].replaceAll("^\\p{Punct}+|\\p{Punct}+$","");
            }

            if (enableMiscue) {
                Patch<String> diff = DiffUtils.diff(Arrays.asList(referenceWords), recognizedWords, true);

                int currentIdx = 0;
                for (AbstractDelta<String> d : diff.getDeltas()) {
                    if (d.getType() == DeltaType.EQUAL) {
                        for (int i = currentIdx; i < currentIdx + d.getSource().size(); i++) {
                            finalWords.add(pronWords.get(i));
                        }
                        currentIdx += d.getTarget().size();
                    }
                    if (d.getType() == DeltaType.DELETE || d.getType() == DeltaType.CHANGE) {
                        for (String w : d.getSource().getLines()) {
                            finalWords.add(new Word(w, "Omission"));
                        }
                    }
                    if (d.getType() == DeltaType.INSERT || d.getType() == DeltaType.CHANGE) {
                        for (int i = currentIdx; i < currentIdx + d.getTarget().size(); i++) {
                            Word w = pronWords.get(i);
                            w.errorType = "Insertion";
                            finalWords.add(w);
                        }
                        currentIdx += d.getTarget().size();
                    }
                }
            }
            else {
                finalWords = pronWords;
            }

            //We can calculate whole accuracy by averaging
            double totalAccuracyScore = 0;
            int accuracyCount = 0;
            int validCount = 0;
            for (Word word : finalWords) {
                if (!"Insertion".equals(word.errorType)) {
                    totalAccuracyScore += word.accuracyScore;
                    accuracyCount += 1;
                }

                if ("None".equals(word.errorType)) {
                    validCount += 1;
                }
            }
            double accuracyScore = totalAccuracyScore / accuracyCount;

            //Re-calculate fluency score
            double fluencyScoreSum = 0;
            long durationSum = 0;
            for (int i = 0; i < durations.size(); i++) {
                fluencyScoreSum += fluencyScores.get(i)*durations.get(i);
                durationSum += durations.get(i);
            }
            double fluencyScore = fluencyScoreSum / durationSum;

            //Re-calculate prosody score
            double prosodyScoreSum = 0;
            for (int i = 0; i < prosodyScores.size(); i++) {
                prosodyScoreSum += prosodyScores.get(i);
            }
            double prosodyScore = prosodyScoreSum / prosodyScores.size();

            // Calculate whole completeness score
            double completenessScore = (double)validCount / referenceWords.length * 100;
            completenessScore = completenessScore <= 100 ? completenessScore : 100;

            System.out.println("Paragraph accuracy score: " + accuracyScore + " prosody score: " + prosodyScore +
                    ", completeness score: " +completenessScore +
                    " , fluency score: " + fluencyScore);
            for (Word w : finalWords) {
                System.out.println(" word: " + w.word + "\taccuracy score: " +
                        w.accuracyScore + "\terror type: " + w.errorType);
            }
        }
        speechConfig.close();
        audioConfig.close();
        recognizer.close();
    }

    public static class Word {
        public String word;
        public String errorType;
        public double accuracyScore;
        public Word(String word, String errorType) {
            this.word = word;
            this.errorType = errorType;
            this.accuracyScore = 0;
        }

        public Word(String word, String errorType, double accuracyScore) {
            this(word, errorType);
            this.accuracyScore = accuracyScore;
        }
    }

}
