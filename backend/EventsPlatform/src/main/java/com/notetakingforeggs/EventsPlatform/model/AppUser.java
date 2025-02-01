package com.notetakingforeggs.EventsPlatform.model;


import jakarta.persistence.*;
import lombok.Data;

import java.util.List;
@Entity
@Data
@Table(name="app_user")
public class AppUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String firebaseUid;
    private String googleUid;
    private String name;
    private String email;

    private String refreshToken;

    private Boolean isStaff;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Attendee> attendedEvents; // Track which events the user is attending - its a join table, so attendee is kind of like events for users and users for events...
}


