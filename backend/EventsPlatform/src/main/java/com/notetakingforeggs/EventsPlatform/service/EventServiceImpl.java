package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.Event;
import com.notetakingforeggs.EventsPlatform.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EventServiceImpl implements EventService{

    @Autowired
    EventRepository eventRepository;

    @Override
    public List<Event> getAll() {
        return eventRepository.findAll();
    }

    @Override
    public List<Event> getByEventName(String name) {
        return eventRepository.findByEventName(name);
    }

    @Override
    public Event getById(Long id) {
        return eventRepository.getReferenceById(id);
    }

    @Override
    public Event deleteById(Long id) {
        try{
            Event temp = eventRepository.getReferenceById(id);
            eventRepository.deleteById(id);
            return temp;
        }
        catch (Exception e) {
            // TODO handle better
            throw new RuntimeException(e);
            // return false?
        }
    }

    @Override
    public Event update(Event updatedEvent, Long id) {

        try{
            Optional<Event> originalEvent = eventRepository.findById(id);
            originalEvent = Optional.ofNullable(updatedEvent);
            return eventRepository.save(updatedEvent);

        } catch (Exception e) {
            // TODO handle better
            throw new RuntimeException(e);
        }

    }

    @Override
    public Event add(Event newEvent) {
        try{
            return eventRepository.save(newEvent);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
