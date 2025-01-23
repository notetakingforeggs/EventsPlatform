package com.notetakingforeggs.EventsPlatform.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;
import java.util.List;

@Entity
@Data
public class AppEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String eventName;

    private ZonedDateTime startDate;

    private ZonedDateTime endDate;

    @ManyToMany
    @JoinTable(
        name = "event_attendees",
        joinColumns = @JoinColumn(name = "event_id"),
        inverseJoinColumns =@JoinColumn(name = "user_id")
    )
    private List<AppUser> attendees;

}
