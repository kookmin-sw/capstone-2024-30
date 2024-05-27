package com.example.capstone.domain.qna.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.*;
import com.amazonaws.util.IOUtils;
import com.example.capstone.domain.qna.entity.FAQ;
import com.example.capstone.domain.qna.entity.FAQImage;
import com.example.capstone.domain.qna.entity.Question;
import com.example.capstone.domain.qna.entity.QuestionImage;
import com.example.capstone.domain.qna.exception.FAQNotFoundException;
import com.example.capstone.domain.qna.exception.QuestionNotFoundException;
import com.example.capstone.domain.qna.repository.FAQImageRepository;
import com.example.capstone.domain.qna.repository.FAQRepository;
import com.example.capstone.domain.qna.repository.QuestionImageRepository;
import com.example.capstone.domain.qna.repository.QuestionRepository;
import com.example.capstone.global.error.exception.BusinessException;
import com.example.capstone.global.error.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.*;

@Service
@RequiredArgsConstructor
public class ImageService {
    private final AmazonS3 amazonS3;

    @Value("${s3.bucket.name}")
    private String bucketName;
    @Value("${s3.cloud.front.url}")
    private String cloudFront;

    private final QuestionImageRepository questionImageRepository;

    private final QuestionRepository questionRepository;

    private final FAQImageRepository faqImageRepository;

    private final FAQRepository faqRepository;

    public List<String> upload(List<MultipartFile> images, Long questionId, boolean isFAQ) {
        List<String> imgUrlList = new ArrayList<>();

        for(MultipartFile image : images) {
            if (image.isEmpty() || Objects.isNull(image.getOriginalFilename())) {
                throw new BusinessException(ErrorCode.EMPTY_FILE_EXCEPTION);
            }
            String url = this.uploadImage(image);
            imgUrlList.add(url);
        }

        if(isFAQ) {
            FAQ faq = faqRepository.findById(questionId).orElseThrow(() ->
                new FAQNotFoundException(questionId)
            );
            for(String url : imgUrlList) {
                faqImageRepository.save(FAQImage.builder().faqId(faq).url(url).build());
            }
        }
        else {
            Question question = questionRepository.findById(questionId).orElseThrow(() ->
                new QuestionNotFoundException(questionId)
            );
            for(String url : imgUrlList) {
                questionImageRepository.save(QuestionImage.builder().questionId(question).url(url).build());
            }
        }

        return imgUrlList;
    }

    private String uploadImage(MultipartFile image) {
        this.validateImageFileExtension(image.getOriginalFilename());
        try {
            return this.uploadImageToS3(image);
        } catch (IOException e) {
            throw new BusinessException(ErrorCode.IO_EXCEPTION_ON_IMAGE_UPLOAD);
        }
    }

    private void validateImageFileExtension(String filename) {
        int lastDotIndex = filename.lastIndexOf(".");
        if (lastDotIndex == -1) {
            throw new BusinessException(ErrorCode.NO_FILE_EXTENSION);
        }

        String extension = filename.substring(lastDotIndex + 1).toLowerCase();
        List<String> allowedExtensionList = Arrays.asList("jpg", "jpeg", "png", "gif");

        if (!allowedExtensionList.contains(extension)) {
            throw new BusinessException(ErrorCode.INVALID_FILE_EXTENSION);
        }
    }

    private String uploadImageToS3(MultipartFile image) throws IOException {
        String originalFilename = image.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));

        String s3FileName = UUID.randomUUID().toString().substring(0, 10) + originalFilename;

        InputStream is = image.getInputStream();
        byte[] bytes = IOUtils.toByteArray(is);

        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentType("image/" + extension);
        metadata.setContentLength(bytes.length);
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);

        try {
            PutObjectRequest putObjectRequest =
                    new PutObjectRequest(bucketName, s3FileName, byteArrayInputStream, metadata)
                            .withCannedAcl(CannedAccessControlList.PublicRead);
            amazonS3.putObject(putObjectRequest);
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.PUT_OBJECT_EXCEPTION);
        } finally {
            byteArrayInputStream.close();
            is.close();
        }

        return "https://" + cloudFront + "/" + s3FileName;
    }

    public void deleteImageFromS3(String imageAddress) {
        String key = getKeyFromImageAddress(imageAddress);
        try {
            amazonS3.deleteObject(new DeleteObjectRequest(bucketName, key));
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.IO_EXCEPTION_ON_IMAGE_DELETE);
        }
    }

    private String getKeyFromImageAddress(String imageAddress) {
        try{
            URL url = new URL(imageAddress);
            String decodingKey = URLDecoder.decode(url.getPath(), "UTF-8");
            return decodingKey.substring(1); // 맨 앞의 '/' 제거
        }catch (MalformedURLException | UnsupportedEncodingException e){
            throw new BusinessException(ErrorCode.IO_EXCEPTION_ON_IMAGE_DELETE);
        }
    }

    public List<String> getUrlListByQuestionId(Long questionId) {
        return questionImageRepository.findByQuestionId(questionId);
    }

    public List<String> getUrlListByFAQId(Long faqId) {
        return faqImageRepository.findByFAQId(faqId);
    }

    public void deleteByQuestionId(Long questionId) {
        questionImageRepository.deleteByQuestionId(questionId);
    }

    public void deleteByFAQId(Long faqId) {
        faqImageRepository.deleteByFAQId(faqId);
    }
}
