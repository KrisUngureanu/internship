package kz.bitlab.mainservice.controller;


import kz.bitlab.mainservice.dto.AttachmentDto;
import kz.bitlab.mainservice.service.AttachmentService;
import kz.bitlab.mainservice.exception.AttachmentDownloadException;
import kz.bitlab.mainservice.exception.AttachmentUploadException;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping(value = "/attachment")
public class AttachmentController {

    private final AttachmentService attachmentService;

    public AttachmentController(AttachmentService attachmentService) {
        this.attachmentService = attachmentService;
    }

    @PostMapping(value = "/upload")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER')")
    public ResponseEntity<AttachmentDto> upload(@RequestParam(name = "file") MultipartFile file,
                                                @RequestParam(name = "lessonId") Long lessonId) {
        try {
            AttachmentDto attachmentDTO = attachmentService.uploadAttachment(file, lessonId);
            return ResponseEntity.ok(attachmentDTO);
        } catch (AttachmentUploadException e) {
            return ResponseEntity.status(500).body(null);
        }
    }


    @GetMapping(value = "/download/{fileName}")
    @PreAuthorize("hasAnyRole('ADMIN', 'TEACHER', 'USER')")
    public ResponseEntity<ByteArrayResource> downloadFile(@PathVariable(name = "fileName") String fileName) {
        try {
            ByteArrayResource resource = attachmentService.downloadFile(fileName);
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
                    .body(resource);
        } catch (AttachmentDownloadException e) {
            return ResponseEntity.status(500).body(null);
        }
    }

    @GetMapping(value = "/lesson/{lessonId}")
    @PreAuthorize("hasAnyRole('USER')")
    public ResponseEntity<?> getAttachmentsByLessonId(@PathVariable Long lessonId) {
        try {
            return ResponseEntity.ok(attachmentService.getAttachmentsByLessonId(lessonId));
        } catch (Exception e) {
            return ResponseEntity.status(404).body("No attachments found");
        }
    }
}
