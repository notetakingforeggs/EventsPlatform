//package com.notetakingforeggs.EventsPlatform.service;
//
//import com.google.api.client.auth.oauth2.Credential;
//import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
//import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
//import com.google.api.client.http.HttpTransport;
//import com.google.api.client.http.javanet.NetHttpTransport;
//import com.google.api.client.json.jackson2.JacksonFactory;
//import com.google.api.client.util.DateTime;
//import com.google.api.services.calendar.model.Event;
//import com.google.api.services.calendar.model.Events;
//import com.notetakingforeggs.EventsPlatform.model.AppEvent;
//import com.google.api.services.calendar.Calendar;
//import org.springframework.context.annotation.Bean;
//import org.springframework.stereotype.Service;
//
//
//import java.io.IOException;
//import java.util.List;
//
//@Service
//public class GoogleCalendarServiceImpl implements CalendarService {
//
//private final HttpTransport httpTransport;
//
//    public GoogleCalendarServiceImpl(HttpTransport httpTransport) {
//        this.httpTransport = httpTransport;
//    }
//
//
//    @Override
//    public Event addEvent(String calendarId, Event event) {
//
//
//            if (calendarId == null) {
//                calendarId = "primary";
//            }
//
//            try{
//                Calendar calendarService = new Calendar.Builder(httpTransport, JacksonFactory.getDefaultInstance(), credential)
//                        .setApplicationName("why put a name here?")
//                        .build();
//
//            calendarService.events().insert(calendarId, event).execute();
//            return event;
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//    }
//
//    @Override
//    public List<AppEvent> getEvents(String calendarId) throws IOException {
//
//        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
//
//        // !!!!!!!!!!! here is where the credentials get fed in. can i just feed in the ones from front end? !!!!!!!!!!!!!!!!!!!
//        Calendar service =
//                new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
//                        .setApplicationName(APPLICATION_NAME)
//                        .build();
//
//        // List the next 10 events from the primary calendar.
//        DateTime now = new DateTime(System.currentTimeMillis());
//        Events events = service.events().list("primary")
//                .setMaxResults(10)
//                .setTimeMin(now)
//                .setOrderBy("startTime")
//                .setSingleEvents(true)
//                .execute();
//        List<Event> items = events.getItems();
//        if (items.isEmpty()) {
//            System.out.println("No upcoming events found.");
//        } else {
//            System.out.println("Upcoming events");
//            for (Event event : items) {
//                DateTime start = event.getStart().getDateTime();
//                if (start == null) {
//                    start = event.getStart().getDate();
//                }
//                System.out.printf("%s (%s)\n", event.getSummary(), start);
//            }
//        }
//
//        return List.of(null);
//    }
//}
