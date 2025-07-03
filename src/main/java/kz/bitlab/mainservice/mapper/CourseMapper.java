package kz.bitlab.mainservice.mapper;

import kz.bitlab.mainservice.dto.CourseDto;
import kz.bitlab.mainservice.model.Course;

public class CourseMapper {

    public static CourseDto toDto(Course entity) {
        if (entity == null) return null;

        CourseDto dto = new CourseDto();
        dto.setId(entity.getId());
        dto.setName(entity.getName());
        dto.setDescription(entity.getDescription());
        dto.setCreatedTime(entity.getCreatedTime());
        dto.setUpdatedTime(entity.getUpdatedTime());
        return dto;
    }

    public static Course toEntity(CourseDto dto) {
        if (dto == null) return null;

        Course entity = new Course();
        entity.setId(dto.getId());
        entity.setName(dto.getName());
        entity.setDescription(dto.getDescription());
        entity.setCreatedTime(dto.getCreatedTime());
        entity.setUpdatedTime(dto.getUpdatedTime());
        return entity;
    }
}
