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

    private String firebaseUid;

    private String googleUid;

    //  do not store the id token, store the authToken
    private String googleAccessToken;

    // jankplan just to see, send id token over in user, verify, then nullify for storage....?
    private String refreshToken;

    private String name;

    private String email;

    private Boolean isStaff;

    @ManyToMany(mappedBy = "attendees")
    private List<AppEvent> events;



}
