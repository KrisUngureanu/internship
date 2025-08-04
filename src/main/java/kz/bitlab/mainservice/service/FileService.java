package kz.bitlab.mainservice.service;

import io.minio.GetObjectArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;

@Slf4j
@Service
@RequiredArgsConstructor
public class FileService {
    private final MinioClient minioClient;

    @Value("${minio.bucket}")
    private String bucket;

    public String uploadFile(MultipartFile file){
        try{
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucket)
                            .object(file.getOriginalFilename())
                            .stream(file.getInputStream(), file.getSize(), -1)
                            .contentType(file.getContentType())
                            .build()
            );
            log.info("File uploaded successfully");
            return "File uploaded successfully";
        }catch (Exception e){
            log.error("Some errors on file upload");
            return "Error occurred while uploading the file";
        }

    }

    public ByteArrayResource downloadFile(String fileName){
        try {
            GetObjectArgs getObjectArgs = GetObjectArgs
                    .builder()
                    .bucket(bucket)
                    .object(fileName)
                    .build();

            InputStream stream = minioClient.getObject(getObjectArgs);
            byte[] bytes = IOUtils.toByteArray(stream);
            stream.close();
            return new ByteArrayResource(bytes);
        } catch (Exception e) {
            log.error("Error while downloading course file: {}", fileName, e);
            return null;
        }
    }
}
