package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.Event;
import com.notetakingforeggs.EventsPlatform.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public interface EventService {

    List<Event> getAllEvents();
    List<Event> getByName(String name);
    Event getById(Long id);
    Boolean deleteById(Long id);
    Boolean update(Event updatedEvent, Long id);
    Event add(Event newEvent);

}
