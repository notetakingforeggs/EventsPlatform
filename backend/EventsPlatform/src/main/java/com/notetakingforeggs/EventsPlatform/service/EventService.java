package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.AppEvent;

import java.util.List;

public interface EventService {

    List<AppEvent> getAll();
    List<AppEvent> getByEventName(String name);
    AppEvent getById(Long id);
    AppEvent deleteById(Long id);
    AppEvent update(AppEvent updatedEvent, Long id);
    AppEvent add(AppEvent newEvent);

}
