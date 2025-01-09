package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.Event;
import com.notetakingforeggs.EventsPlatform.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventServiceImpl implements EventService{

    @Autowired
    EventRepository eventRepository;

    @Override
    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    // what is the auto findby attribute that is offered by jpa repo?
    @Override
    public List<Event> getByName(String name) {
//        return eventRepository.findBy(name);
        return null;
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
            eventRepository.deleteById(id);
            return eventRepository.save(updatedEvent);

        } catch (Exception e) {
            // TODO handle better
            throw new RuntimeException(e);
        }

    }

    @Override
    public Event add(Event newEvent) {
        try{
            System.out.println("000000000000");
            System.out.println(newEvent.getStartDate().getZone());
            return eventRepository.save(newEvent);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
