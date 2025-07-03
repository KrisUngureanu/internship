package kz.bitlab.mainservice.repository;

import kz.bitlab.mainservice.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Long> {
    @Override
    List<Lesson> findAll();

    List<Lesson> findAllByChapterId(Long chapterId);
}