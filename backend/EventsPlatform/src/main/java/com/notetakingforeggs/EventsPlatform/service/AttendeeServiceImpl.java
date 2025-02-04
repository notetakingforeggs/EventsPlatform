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

        // TODO this fucked up becasue i havent decided if i am using objects or ids in the join table. do this after lunch
        newAttendee.setEventId(eventId);
        newAttendee.setUserGoogleId(userGoogleId);
        return repository.save(newAttendee);

    }
}
