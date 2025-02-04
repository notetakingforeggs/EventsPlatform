package com.notetakingforeggs.EventsPlatform.service.business;

import com.notetakingforeggs.EventsPlatform.model.AppEvent;
import com.notetakingforeggs.EventsPlatform.repository.EventRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EventServiceImpl implements EventService {


    private final EventRepository eventRepository;

    public EventServiceImpl(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }

    @Override
    public List<AppEvent> getAll() {
        return eventRepository.findAll();
    }

    @Override
    public List<AppEvent> getByEventName(String name) {
        return eventRepository.findByEventName(name);
    }

    @Override
    public AppEvent getById(Long id) {
        return eventRepository.getReferenceById(id);
    }

    @Override
    public AppEvent deleteById(Long id) {
        try{
            AppEvent temp = eventRepository.getReferenceById(id);
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
    public AppEvent update(AppEvent updatedEvent, Long id) {

        try{
            Optional<AppEvent> originalEvent = eventRepository.findById(id);
            originalEvent = Optional.ofNullable(updatedEvent);
            return eventRepository.save(updatedEvent);

        } catch (Exception e) {
            // TODO handle better
            throw new RuntimeException(e);
        }

    }

    @Override
    public AppEvent add(AppEvent newEvent) {
        try{
            return eventRepository.save(newEvent);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
