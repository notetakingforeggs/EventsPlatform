package com.notetakingforeggs.EventsPlatform.controller;

import com.notetakingforeggs.EventsPlatform.model.AppEvent;
import com.notetakingforeggs.EventsPlatform.service.EventServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/events")
public class EventController {

    private final EventServiceImpl eventService;

    public EventController(EventServiceImpl eventService) {
        this.eventService = eventService;
    }

    @GetMapping
    public ResponseEntity<List<AppEvent>> getAllEvents(){
        System.out.println("getting all events");
        List<AppEvent> events = eventService.getAll();
        return new ResponseEntity<>(events, HttpStatus.OK);
    }

    @PostMapping("/add-event")
    public ResponseEntity<AppEvent> addEvent(@RequestBody AppEvent newEvent){
        // TODO need to convert into correct shape for backend, probs should convert zones on frontend
        System.out.println("add event post req received");
        System.out.println(newEvent);
        eventService.add(newEvent);
        return new ResponseEntity<>(newEvent, HttpStatus.CREATED);
    }

    @PostMapping("/attend-event/{eventId}/attendees/{userGoogleId}")
    public ResponseEntity<String> attendEvent(@PathVariable String eventId, @PathVariable String userGoogleId){
        System.out.println("Attend Event request received");
        eventService.
        return new ResponseEntity<>("successful attend logged", HttpStatus.CREATED);
    }


}
