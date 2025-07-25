package kz.bitlab.mainservice.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import kz.bitlab.mainservice.dto.ChapterDto;
import kz.bitlab.mainservice.service.ChapterService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/chapters")
@Tag(name = "Chapter", description = "Operations about chapters")
public class ChapterController {

    private final ChapterService chapterService;

    public ChapterController(ChapterService chapterService) {
        this.chapterService = chapterService;
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('USER')")
    @Operation(summary = "Get all chapters")
    public List<ChapterDto> getAllChapters() {
        return chapterService.getAllChapters();
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('USER')")
    @Operation(summary = "Get chapter by id")
    public ChapterDto getChapterById(@PathVariable Long id) {
        return chapterService.getChapterById(id);
    }

    @PostMapping
    @PreAuthorize("hasAnyRole('ADMIN')")
    @Operation(summary = "Create chapter")
    public ChapterDto createChapter(@RequestBody ChapterDto dto) {
        return chapterService.createChapter(dto);
    }
}