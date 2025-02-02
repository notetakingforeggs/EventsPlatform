package com.notetakingforeggs.EventsPlatform.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;
import java.util.List;

@Entity
@Data
@Table(name="app_event")
public class AppEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String eventName;
    private String eventDetails;
    private ZonedDateTime startDate;
    private ZonedDateTime endDate;

    @OneToMany(mappedBy = "event", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Attendee> attendees;
}
