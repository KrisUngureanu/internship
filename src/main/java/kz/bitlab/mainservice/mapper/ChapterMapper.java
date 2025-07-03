package kz.bitlab.mainservice.mapper;

import kz.bitlab.mainservice.dto.ChapterDto;
import kz.bitlab.mainservice.model.Chapter;
import kz.bitlab.mainservice.model.Course;

public class ChapterMapper {

    public static ChapterDto toDto(Chapter entity) {
        if (entity == null) return null;

        ChapterDto dto = new ChapterDto();
        dto.setId(entity.getId());
        dto.setName(entity.getName());
        dto.setDescription(entity.getDescription());
        dto.setOrder(entity.getOrder());
        dto.setCourseId(entity.getCourse() != null ? entity.getCourse().getId() : null);
        dto.setCreatedTime(entity.getCreatedTime());
        dto.setUpdatedTime(entity.getUpdatedTime());
        return dto;
    }

    public static Chapter toEntity(ChapterDto dto, Course course) {
        if (dto == null) return null;

        Chapter entity = new Chapter();
        entity.setId(dto.getId());
        entity.setName(dto.getName());
        entity.setDescription(dto.getDescription());
        entity.setOrder(dto.getOrder());
        entity.setCourse(course);
        entity.setCreatedTime(dto.getCreatedTime());
        entity.setUpdatedTime(dto.getUpdatedTime());
        return entity;
    }
}