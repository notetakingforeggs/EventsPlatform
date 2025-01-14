package com.notetakingforeggs.EventsPlatform.model;


import jakarta.persistence.*;
import lombok.Data;

import java.util.List;
@Entity
@Data
public class AppUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String email;

    private Boolean isStaff;

    @ManyToMany(mappedBy = "attendees")
    private List<Event> events;

}
