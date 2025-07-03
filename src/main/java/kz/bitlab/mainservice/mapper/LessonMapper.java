package kz.bitlab.mainservice.mapper;

import kz.bitlab.mainservice.dto.LessonDto;
import kz.bitlab.mainservice.model.Chapter;
import kz.bitlab.mainservice.model.Lesson;

public class LessonMapper {

    public static LessonDto toDto(Lesson entity) {
        if (entity == null) return null;

        LessonDto dto = new LessonDto();
        dto.setId(entity.getId());
        dto.setName(entity.getName());
        dto.setDescription(entity.getDescription());
        dto.setContent(entity.getContent());
        dto.setOrder(entity.getOrder());
        dto.setChapterId(entity.getChapter() != null ? entity.getChapter().getId() : null);
        dto.setCreatedTime(entity.getCreatedTime());
        dto.setUpdatedTime(entity.getUpdatedTime());
        return dto;
    }

    public static Lesson toEntity(LessonDto dto, Chapter chapter) {
        if (dto == null) return null;

        Lesson entity = new Lesson();
        entity.setId(dto.getId());
        entity.setName(dto.getName());
        entity.setDescription(dto.getDescription());
        entity.setContent(dto.getContent());
        entity.setOrder(dto.getOrder());
        entity.setChapter(chapter);
        entity.setCreatedTime(dto.getCreatedTime());
        entity.setUpdatedTime(dto.getUpdatedTime());
        return entity;
    }
}