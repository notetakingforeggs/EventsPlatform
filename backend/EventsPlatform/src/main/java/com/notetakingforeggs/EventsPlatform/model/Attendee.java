package com.notetakingforeggs.EventsPlatform.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Attendee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private AppUser user;

    @ManyToOne
    @JoinColumn(name = "event_id", nullable = false)
    private AppEvent event;

    private Boolean confirmed;  // Can track if the user has confirmed attendance
}