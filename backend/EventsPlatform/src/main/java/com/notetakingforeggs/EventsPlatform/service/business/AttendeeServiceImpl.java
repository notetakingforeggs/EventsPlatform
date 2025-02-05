package com.notetakingforeggs.EventsPlatform.service.business;

import com.notetakingforeggs.EventsPlatform.model.AppEvent;
import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.model.Attendee;
import com.notetakingforeggs.EventsPlatform.repository.AttendeeRepository;
import org.springframework.stereotype.Service;

@Service
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
        System.out.println("in attendee service");
        Attendee newAttendee = new Attendee();


        System.out.println("getting user by googleId:" + userGoogleId);
        AppUser userToBecomeAttendee = userService.getByGoogleUid(userGoogleId);
        System.out.println("user: " + userToBecomeAttendee);

        System.out.println("getting event by event id");
        AppEvent eventToBeAttended = eventService.getById(eventId);
        System.out.println(eventToBeAttended);

        newAttendee.setEvent(eventToBeAttended);
        newAttendee.setUser(userToBecomeAttendee);
        //TODO break these down figure out bug
//        newAttendee.setUser(userService.getByGoogleUid(userGoogleId));
//        newAttendee.setEvent(eventService.getById(eventId));
        System.out.println(newAttendee);
        return repository.save(newAttendee);

    }
}
