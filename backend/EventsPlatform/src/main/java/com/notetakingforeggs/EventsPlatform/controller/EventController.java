package com.notetakingforeggs.EventsPlatform.controller;

import com.notetakingforeggs.EventsPlatform.model.Event;
import com.notetakingforeggs.EventsPlatform.service.EventServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/events")
public class EventController {
    @Autowired
    EventServiceImpl eventService;

    @GetMapping
    public ResponseEntity<List<Event>> getAllEvents(){
        System.out.println("getting all events");
        List<Event> events = eventService.getAllEvents();
        return new ResponseEntity<>(events, HttpStatus.OK);
    }

    // TODO better to return the newly saved event than true to ensure successful posting
    @PostMapping
    public ResponseEntity<Event> addEvent(@RequestBody Event newEvent){
        System.out.println("post req received");
        System.out.println(newEvent);
        eventService.add(newEvent);
        return new ResponseEntity<>(newEvent, HttpStatus.OK);
    }



}
