package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.Attendee;
import com.notetakingforeggs.EventsPlatform.repository.AttendeeRepository;

public class AttendeeServiceImpl implements AttendeeService {

    private final AttendeeRepository repository;

    public AttendeeServiceImpl(AttendeeRepository repository) {
        this.repository = repository;
    }

    @Override
    public Attendee becomeAttendee(Long eventId, String userGoogleId) {
        Attendee newAttendee = new Attendee();
        newAttendee.setEventId(eventId);
        newAttendee.setUserGoogleId(userGoogleId);
        return repository.save(newAttendee);

    }
}
