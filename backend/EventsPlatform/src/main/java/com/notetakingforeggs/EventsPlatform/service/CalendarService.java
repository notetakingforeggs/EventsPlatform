package com.notetakingforeggs.EventsPlatform.service;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.notetakingforeggs.EventsPlatform.model.Event;

import java.util.List;

public interface CalendarService {
    Event addEvent(Event event, String calendarId, GoogleCredential credential);
    List<Event> getEvents(String calendarId, GoogleCredential credential);
}
