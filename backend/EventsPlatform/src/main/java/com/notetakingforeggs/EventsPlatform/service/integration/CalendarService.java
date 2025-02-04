package com.notetakingforeggs.EventsPlatform.service.integration;

import com.google.api.services.calendar.model.Event;
import com.notetakingforeggs.EventsPlatform.model.AppEvent;

import java.io.IOException;
import java.util.List;

public interface CalendarService {
    Event addEvent( String calendarId, Event event);
    List<AppEvent> getEvents(String calendarId) throws IOException;
}
