package com.notetakingforeggs.EventsPlatform.service;

import com.google.api.services.calendar.model.Event;
import com.notetakingforeggs.EventsPlatform.model.AppEvent;

import java.util.List;

public interface CalendarService {
    Event addEvent( String calendarId, Event event);
    List<AppEvent> getEvents(String calendarId);
}
