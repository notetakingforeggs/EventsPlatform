package com.notetakingforeggs.EventsPlatform.service;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.notetakingforeggs.EventsPlatform.model.Event;
import com.google.api.services.calendar.Calendar;
import org.springframework.stereotype.Service;


import java.util.List;
@Service
public class GoogleCalendarServiceImpl implements CalendarService{

    private final HttpTransport httpTransport;

    public GoogleCalendarServiceImpl(HttpTransport httpTransport) {
        this.httpTransport = httpTransport;
    }

    @Override
    public Event addEvent(Event event, String calendarId, GoogleCredential credential) {
        if (calendarId == null){
            calendarId = "primary";
        }
        Calendar calendarService = new Calendar.Builder(httpTransport, JacksonFactory.getDefaultInstance(), credential)
                .setApplicationName("why put a name here?")
                .build();

        calendarService.events().insert(calendarId, event).execute();

    }

    @Override
    public List<Event> getEvents(String calendarId, GoogleCredential credential) {
        return List.of();
    }
}
