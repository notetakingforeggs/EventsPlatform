package com.notetakingforeggs.EventsPlatform.controller;

import com.notetakingforeggs.EventsPlatform.model.AppEvent;
import com.notetakingforeggs.EventsPlatform.service.business.AttendeeService;
import com.notetakingforeggs.EventsPlatform.service.business.EventServiceImpl;
import com.notetakingforeggs.EventsPlatform.service.integration.GoogleCalendarServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

@RestController
@RequestMapping("api/v1/events")
public class EventController {

    private final EventServiceImpl eventService;
    private final AttendeeService attendeeService;
    private final GoogleCalendarServiceImpl googleCalendarService;

    public EventController(EventServiceImpl eventService, AttendeeService attendeeService, GoogleCalendarServiceImpl googleCalendarService) {
        this.eventService = eventService;
        this.attendeeService = attendeeService;
        this.googleCalendarService = googleCalendarService;
    }

    @GetMapping
    public ResponseEntity<List<AppEvent>> getAllEvents() {
        System.out.println("getting all events");
        List<AppEvent> events = eventService.getAll();
        return new ResponseEntity<>(events, HttpStatus.OK);
    }

    @PostMapping("/add-event")
    public ResponseEntity<AppEvent> addEvent(@RequestBody AppEvent newEvent) {
        System.out.println("add event post req received");
        System.out.println(newEvent);
        eventService.add(newEvent);
        return new ResponseEntity<>(newEvent, HttpStatus.CREATED);
    }

    @PostMapping("/attend-event/{eventId}/attendees/{userGoogleId}")
    public ResponseEntity<String> attendEvent(@PathVariable Long eventId, @PathVariable String userGoogleId) throws GeneralSecurityException, IOException {
        System.out.println("Attend Event request received");
        // could return this attendee to the frontend for checks but i think ok?
        if (attendeeService.becomeAttendee(eventId, userGoogleId) != null) {
            // add event to google calendar.
            googleCalendarService.addEvent(null, eventId, userGoogleId);
            return new ResponseEntity<>("successful attend logged", HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>("adding attendee failed", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
