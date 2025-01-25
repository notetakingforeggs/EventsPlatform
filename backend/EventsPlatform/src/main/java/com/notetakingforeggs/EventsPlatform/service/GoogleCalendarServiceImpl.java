package com.notetakingforeggs.EventsPlatform.service;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.calendar.model.Event;
import com.notetakingforeggs.EventsPlatform.model.AppEvent;
import com.google.api.services.calendar.Calendar;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class GoogleCalendarServiceImpl implements CalendarService {

private final HttpTransport httpTransport;

    public GoogleCalendarServiceImpl(HttpTransport httpTransport) {
        this.httpTransport = httpTransport;
    }


    @Override
    public Event addEvent(String calendarId, Event event) {

//        Credential credential =

            if (calendarId == null) {
                calendarId = "primary";
            }

            try{
                Calendar calendarService = new Calendar.Builder(httpTransport, JacksonFactory.getDefaultInstance(), credential)
                        .setApplicationName("why put a name here?")
                        .build();

            calendarService.events().insert(calendarId, event).execute();
            return event;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<AppEvent> getEvents(String calendarId) {
        return List.of();
    }
}
