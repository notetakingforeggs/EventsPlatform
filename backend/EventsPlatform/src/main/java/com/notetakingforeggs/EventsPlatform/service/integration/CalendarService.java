//package com.notetakingforeggs.EventsPlatform.service.integration;
//
//import com.google.api.services.calendar.model.Event;
//import com.notetakingforeggs.EventsPlatform.model.AppEvent;
//
//import java.io.IOException;
//import java.security.GeneralSecurityException;
//import java.util.List;
//
//public interface CalendarService {
//    Event addEvent( String calendarId, Event event, String userGoogleId) throws IOException;
//    List<AppEvent> getEvents(String calendarId) throws IOException, GeneralSecurityException;
//}
//TODO why interface this? seems a little specific unlikely to be multiple instantiatons of it....