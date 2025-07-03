package kz.bitlab.mainservice.repository;

import kz.bitlab.mainservice.model.Chapter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChapterRepository extends JpaRepository<Chapter, Long> {
    @Override
    List<Chapter> findAll();

    List<Chapter> findAllByCourseId(Long courseId);
}