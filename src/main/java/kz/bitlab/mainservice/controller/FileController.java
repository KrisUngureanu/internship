package kz.bitlab.mainservice.controller;

import kz.bitlab.mainservice.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/file")
public class FileController {

    private final FileService fileService;

    @PostMapping(value = "/upload")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public String upload(@RequestParam(name = "file")MultipartFile file){
        return fileService.uploadFile(file);
    }

    @GetMapping(value = "/download/{file}")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public ResponseEntity<ByteArrayResource> downloadFile(@PathVariable(name = "file") String filename){
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .header(HttpHeaders.CONTENT_DISPOSITION,"attachment; filename=\""+filename + "\"")
                .body(fileService.downloadFile(filename));

    }
}
