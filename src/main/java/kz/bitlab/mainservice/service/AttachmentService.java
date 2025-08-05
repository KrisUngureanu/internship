package kz.bitlab.mainservice.service;

import io.minio.GetObjectArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import io.minio.errors.*;
import kz.bitlab.mainservice.dto.AttachmentDto;
import kz.bitlab.mainservice.mapper.AttachmentMapper;
import kz.bitlab.mainservice.model.Attachment;
import kz.bitlab.mainservice.model.Lesson;
import kz.bitlab.mainservice.repository.AttachmentRepository;
import kz.bitlab.mainservice.repository.LessonRepository;
import kz.bitlab.mainservice.exception.AttachmentDownloadException;
import kz.bitlab.mainservice.exception.AttachmentUploadException;
import lombok.RequiredArgsConstructor;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AttachmentService {

    private final MinioClient minioClient;
    private final AttachmentRepository attachmentRepository;
    private final LessonRepository lessonRepository;

    @Value("${minio.url}")
    private String url;

    @Value("${minio.bucket}")
    private String bucket;

    public AttachmentDto uploadAttachment(MultipartFile file, Long lessonId) {
        try {
            Lesson lesson = lessonRepository.findById(lessonId).orElseThrow(() -> new RuntimeException("Lesson not found"));
            String fileUrl = uploadFileToMinIO(file);

            Attachment attachment = Attachment.builder()
                    .name(file.getOriginalFilename())
                    .url(fileUrl)
                    .lesson(lesson)
                    .build();


            Attachment savedAttachment = attachmentRepository.save(attachment);

            return AttachmentMapper.toDto(savedAttachment);
        } catch (Exception e) {
            throw new AttachmentUploadException("Error occurred while uploading the attachment", e);
        }
    }

    public ByteArrayResource downloadFile(String fileName) {
        try {
            InputStream stream = minioClient.getObject(GetObjectArgs.builder()
                    .bucket(bucket)
                    .object(fileName)
                    .build());

            byte[] bytes = IOUtils.toByteArray(stream);
            stream.close();
            return new ByteArrayResource(bytes);
        } catch (Exception e) {
            throw new AttachmentDownloadException("Error occurred while downloading the attachment", e);
        }
    }


    public List<AttachmentDto> getAttachmentsByLessonId(Long lessonId) {
        return attachmentRepository.findAllByLessonId(lessonId)
                .stream()
                .map(AttachmentMapper::toDto)
                .collect(Collectors.toList());
    }


    private String uploadFileToMinIO(MultipartFile file) throws IOException, ServerException, InsufficientDataException, ErrorResponseException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        minioClient.putObject(
                PutObjectArgs.builder()
                        .bucket(bucket)
                        .object(file.getOriginalFilename())
                        .stream(file.getInputStream(), file.getSize(), -1)
                        .contentType(file.getContentType())
                        .build()
        );
        return url + "/" + file.getOriginalFilename();
    }
}
