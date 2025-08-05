package kz.bitlab.mainservice.mapper;

import kz.bitlab.mainservice.dto.AttachmentDto;
import kz.bitlab.mainservice.model.Attachment;
import kz.bitlab.mainservice.model.Lesson;

public class AttachmentMapper {

    // Преобразование из DTO в сущность
    public static Attachment toEntity(AttachmentDto dto, Lesson lesson) {
        return Attachment.builder()
                .id(dto.getId())
                .name(dto.getName())
                .url(dto.getUrl())
                .lesson(lesson)  // Связываем урок с файлом
                .createdTime(dto.getCreatedTime())
                .build();
    }

    // Преобразование из сущности в DTO
    public static AttachmentDto toDto(Attachment attachment) {
        return AttachmentDto.builder()
                .id(attachment.getId())
                .name(attachment.getName())
                .url(attachment.getUrl())
                .lessonId(attachment.getLesson().getId())  // В DTO передаем только ID урока
                .createdTime(attachment.getCreatedTime())
                .build();
    }
}
