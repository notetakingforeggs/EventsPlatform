package com.notetakingforeggs.EventsPlatform.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name="attendee")
public class Attendee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private String userGoogleId;

    @ManyToOne
    @JoinColumn(name = "event_id", nullable = false)
    private Long eventId;

    private Boolean confirmed;  // Can track if the user has confirmed attendance
}