package kz.bitlab.mainservice.repository;

import kz.bitlab.mainservice.model.Attachment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AttachmentRepository extends JpaRepository<Attachment, Long> {

    // Метод для поиска всех прикрепленных файлов по ID урока
    List<Attachment> findAllByLessonId(Long lessonId);
}
