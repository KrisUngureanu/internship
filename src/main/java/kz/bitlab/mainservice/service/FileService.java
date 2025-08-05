package kz.bitlab.mainservice.service;

import io.minio.GetObjectArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import kz.bitlab.mainservice.exception.FileUploadException;
import kz.bitlab.mainservice.exception.FileDownloadException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;

@Slf4j
@Service
@RequiredArgsConstructor
public class FileService {

    private final MinioClient minioClient;

    @Value("${minio.bucket}")
    private String bucket;

    // Загрузка файла в MinIO
    public String uploadFile(MultipartFile file) {
        try {
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucket)
                            .object(file.getOriginalFilename())
                            .stream(file.getInputStream(), file.getSize(), -1)
                            .contentType(file.getContentType())
                            .build()
            );
            log.info("File uploaded successfully: {}", file.getOriginalFilename());
            return "File uploaded successfully";
        } catch (Exception e) {
            log.error("Error occurred while uploading the file: {}", file.getOriginalFilename(), e);
            throw new FileUploadException("Error occurred while uploading the file: " + file.getOriginalFilename(), e);
        }
    }

    // Скачивание файла из MinIO
    public ByteArrayResource downloadFile(String fileName) {
        try {
            GetObjectArgs getObjectArgs = GetObjectArgs
                    .builder()
                    .bucket(bucket)
                    .object(fileName)
                    .build();

            InputStream stream = minioClient.getObject(getObjectArgs);
            byte[] bytes = IOUtils.toByteArray(stream);
            stream.close();
            log.info("File downloaded successfully: {}", fileName);
            return new ByteArrayResource(bytes);
        } catch (Exception e) {
            log.error("Error while downloading the file: {}", fileName, e);
            throw new FileDownloadException("Error while downloading the file: " + fileName, e);
        }
    }
}
