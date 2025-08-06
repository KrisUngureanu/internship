package kz.bitlab.mainservice.service;

import kz.bitlab.mainservice.dto.ChapterDto;
import kz.bitlab.mainservice.mapper.ChapterMapper;
import kz.bitlab.mainservice.model.Chapter;
import kz.bitlab.mainservice.model.Course;
import kz.bitlab.mainservice.repository.ChapterRepository;
import kz.bitlab.mainservice.repository.CourseRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ChapterService {

    private final ChapterRepository chapterRepository;
    private final CourseRepository courseRepository;
    private static final Logger log = LoggerFactory.getLogger(ChapterService.class);

    public ChapterService(ChapterRepository chapterRepository, CourseRepository courseRepository) {
        this.chapterRepository = chapterRepository;
        this.courseRepository = courseRepository;
    }


    public ChapterDto createChapter(ChapterDto dto) {
        log.info("Creating chapter");
        log.debug("chapter details {}", dto);
        Course course = courseRepository.findById(dto.getCourseId()).orElse(null);
        if (course == null) return null;

        Chapter chapter = ChapterMapper.toEntity(dto, course);
        Chapter saved = chapterRepository.save(chapter);
        return ChapterMapper.toDto(saved);
    }

    @Transactional(readOnly = true)
    public List<ChapterDto> getAllChapters() {
        log.info("Getting all chapters");
        return chapterRepository.findAll()
                .stream()
                .map(ChapterMapper::toDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public ChapterDto getChapterById(Long id) {
        return chapterRepository.findById(id)
                .map(ChapterMapper::toDto)
                .orElseThrow(() -> {
                    log.error("chapter not found {}", id);
                    return new IllegalArgumentException("Chapter not found");});
    }
}