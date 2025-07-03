package kz.bitlab.mainservice.service;

import kz.bitlab.mainservice.dto.CourseDto;
import kz.bitlab.mainservice.mapper.CourseMapper;
import kz.bitlab.mainservice.model.Course;
import kz.bitlab.mainservice.repository.CourseRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CourseService {

    private final CourseRepository courseRepository;
    private static final Logger log = LoggerFactory.getLogger(CourseService.class);
    public CourseService(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    public List<CourseDto> getAllCourses() {
        log.info("Getting all courses");
        return courseRepository.findAll()
                .stream()
                .map(CourseMapper::toDto)
                .collect(Collectors.toList());
    }

    public CourseDto getCourseById(Long id) {
        return courseRepository.findById(id)
                .map(CourseMapper::toDto)
                .orElseThrow(() -> {
                    log.error("course not found {}", id);
                    return new IllegalArgumentException("Course not found");});
    }

    public CourseDto createCourse(CourseDto dto) {
        log.info("creating course");
        log.debug("course details {}", dto);
        Course course = CourseMapper.toEntity(dto);
        Course saved = courseRepository.save(course);
        return CourseMapper.toDto(saved);
    }
}