package kz.bitlab.mainservice.service;

import kz.bitlab.mainservice.dto.LessonDto;
import kz.bitlab.mainservice.mapper.LessonMapper;
import kz.bitlab.mainservice.model.Chapter;
import kz.bitlab.mainservice.model.Lesson;
import kz.bitlab.mainservice.repository.ChapterRepository;
import kz.bitlab.mainservice.repository.LessonRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class LessonService {

    private final LessonRepository lessonRepository;
    private final ChapterRepository chapterRepository;
    private static final Logger log = LoggerFactory.getLogger(LessonService.class);

    public LessonService(LessonRepository lessonRepository, ChapterRepository chapterRepository) {
        this.lessonRepository = lessonRepository;
        this.chapterRepository = chapterRepository;
    }

    public List<LessonDto> getLessonsByChapterId(Long chapterId) {
        return lessonRepository.findAllByChapterId(chapterId)
                .stream()
                .map(LessonMapper::toDto)
                .collect(Collectors.toList());
    }

    public LessonDto createLesson(LessonDto dto) {
        Chapter chapter = chapterRepository.findById(dto.getChapterId()).orElseThrow(() -> {
            log.error("chapter not found {}", dto.getChapterId());
            return new IllegalArgumentException("Chapter not found");});
        if (chapter == null) return null;

        Lesson lesson = LessonMapper.toEntity(dto, chapter);
        Lesson saved = lessonRepository.save(lesson);
        log.info("lesson created");
        log.debug("lesson details {}: ", saved);
        return LessonMapper.toDto(saved);
    }

    public List<LessonDto> getAllLessons() {
        log.info("Getting all lessons");
       return lessonRepository.findAll()
               .stream()
               .map(LessonMapper::toDto)
               .collect(Collectors.toList());
    }

    public LessonDto getLessonById(Long id) {
        log.info("Getting lesson by id {}", id);
        return lessonRepository.findById(id)
                .map(LessonMapper::toDto)
                .orElseThrow(() -> {
                    log.error("lesson not found {}", id);
                    return new IllegalArgumentException("Lesson not found");} );
    }
}