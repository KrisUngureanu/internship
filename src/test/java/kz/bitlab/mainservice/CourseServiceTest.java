package kz.bitlab.mainservice;
import kz.bitlab.mainservice.dto.CourseDto;
import kz.bitlab.mainservice.model.Course;
import kz.bitlab.mainservice.repository.CourseRepository;
import kz.bitlab.mainservice.service.CourseService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.Arrays;
import java.util.Optional;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
public class CourseServiceTest {
    private CourseService courseService;
    private CourseRepository courseRepository;
    @BeforeEach
    public void setUp() {
        courseRepository = Mockito.mock(CourseRepository.class);
        courseService = new CourseService(courseRepository);
    }
    @Test
    public void getAllCourses() {
        List<Course> courses = Arrays.asList(new Course(), new Course());
        when(courseRepository.findAll()).thenReturn(courses);
        List<CourseDto> courseDtos = courseService.getAllCourses();
        assertEquals(2, courseDtos.size());
    }

    @Test
    public void getCourseById() {
        Course course = new Course();
        when(courseRepository.findById(anyLong())).thenReturn(Optional.of(course));
        CourseDto courseDto = courseService.getCourseById(1L);
        assertNotNull(courseDto);
    }

    @Test
    public void createCourse() {
        Course course = new Course();
        when(courseRepository.save(any(Course.class))).thenReturn(course);
        CourseDto courseDto = courseService.createCourse(new CourseDto());
    }

    @Test
    public void getCourseByIdButNotFound() {
        when(courseRepository.findById(anyLong())).thenReturn(Optional.empty());
        assertThrows(IllegalArgumentException.class, () -> courseService.getCourseById(1L));
    }

    @Test
    public void createCourseButNull() {
        when(courseRepository.save(any(Course.class))).thenReturn(null);
        assertThrows(IllegalArgumentException.class, () -> courseService.createCourse(new CourseDto()));
    }
    
}
