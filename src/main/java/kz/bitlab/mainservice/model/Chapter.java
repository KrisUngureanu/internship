package kz.bitlab.mainservice.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "chapter")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Chapter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 255)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;
    @Column(name = "sort_order") // ИЛИ chapter_order
    private int order;

    private LocalDateTime createdTime;
    private LocalDateTime updatedTime;

    @ManyToOne
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    @OneToMany(mappedBy = "chapter", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Lesson> lessons;
}
