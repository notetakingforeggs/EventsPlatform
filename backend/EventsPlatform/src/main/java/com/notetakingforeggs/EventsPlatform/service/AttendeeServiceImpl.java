package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.Attendee;
import com.notetakingforeggs.EventsPlatform.repository.AttendeeRepository;

public class AttendeeServiceImpl implements AttendeeService {

    private final AttendeeRepository repository;
    private final UserService userService;
    private final EventService eventService;

    public AttendeeServiceImpl(AttendeeRepository repository, UserService userService, EventService eventService) {
        this.repository = repository;
        this.userService = userService;
        this.eventService = eventService;
    }

    @Override
    public Attendee becomeAttendee(Long eventId, String userGoogleId) {
        Attendee newAttendee = new Attendee();

        // TODO this fucked up becasue i havent decided if i am using objects or ids in the join table. do this after lunch
        newAttendee.setUser(userService.getByGoogleUid(userGoogleId));
        newAttendee.setEvent(eventService.getById(eventId));
        return repository.save(newAttendee);

    }
}
