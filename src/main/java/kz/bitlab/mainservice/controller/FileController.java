package kz.bitlab.mainservice.controller;

import kz.bitlab.mainservice.service.FileService;
import kz.bitlab.mainservice.exception.FileDownloadException;
import kz.bitlab.mainservice.exception.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping(value = "/file")
public class FileController {

    private final FileService fileService;

    @Autowired
    public FileController(FileService fileService) {
        this.fileService = fileService;
    }


    @PostMapping(value = "/upload")
    @PreAuthorize("hasAnyRole('ADMIN','TEACHER')")
    public ResponseEntity<String> upload(@RequestParam(name = "file") MultipartFile file) {
        try {
            String response = fileService.uploadFile(file);
            return ResponseEntity.ok(response);
        } catch (FileUploadException e) {
            return ResponseEntity.status(500).body("Error occurred while uploading the file");
        }
    }


    @GetMapping(value = "/download/{file}")
    @PreAuthorize("hasAnyRole('USER')")
    public ResponseEntity<ByteArrayResource> downloadFile(@PathVariable(name = "file") String filename) {
        try {
            ByteArrayResource resource = fileService.downloadFile(filename);
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                    .body(resource);
        } catch (FileDownloadException e) {
            return ResponseEntity.status(500).body(null);
        }
    }
}
