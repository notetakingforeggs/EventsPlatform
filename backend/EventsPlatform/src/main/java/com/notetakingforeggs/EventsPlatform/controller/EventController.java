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

    @PostMapping
    public ResponseEntity<AppEvent> addEvent(@RequestBody AppEvent newEvent){
        System.out.println("post req received");
        System.out.println(newEvent);
        eventService.add(newEvent);
        return new ResponseEntity<>(newEvent, HttpStatus.OK);
    }



}
