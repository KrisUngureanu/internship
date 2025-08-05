package kz.bitlab.mainservice.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AttachmentDto {
    private Long id;
    private String name;
    private String url;
    private Long lessonId; // ID урока (если нужно передавать только ID урока)
    private LocalDateTime createdTime;
}
