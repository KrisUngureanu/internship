package kz.bitlab.mainservice.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import kz.bitlab.mainservice.dto.LessonDto;
import kz.bitlab.mainservice.service.LessonService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/lesson")
@Tag(name = "Lesson", description = "Operations about lessons")
public class LessonController {

    private final LessonService lessonService;

    public LessonController(LessonService lessonService) {
        this.lessonService = lessonService;
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('USER')")
    @Operation(summary = "Get all lessons")
    public List<LessonDto> getAllLessons() {
        return lessonService.getAllLessons();
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('USER')")
    @Operation(summary = "Get lesson by id")
    public LessonDto getLessonById(@PathVariable Long id) {
        return lessonService.getLessonById(id);
    }

    @PostMapping
    @PreAuthorize("hasAnyRole('ADMIN')")
    @Operation(summary = "Create lesson")
    public LessonDto createLesson(@RequestBody LessonDto dto) {
        return lessonService.createLesson(dto);
    }
}