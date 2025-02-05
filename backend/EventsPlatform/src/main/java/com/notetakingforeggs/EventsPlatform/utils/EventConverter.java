package com.notetakingforeggs.EventsPlatform.utils;

import com.google.api.client.util.DateTime;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.EventAttendee;
import com.google.api.services.calendar.model.EventDateTime;
import com.google.api.services.calendar.model.EventReminder;
import com.notetakingforeggs.EventsPlatform.model.AppEvent;
import com.notetakingforeggs.EventsPlatform.service.business.EventServiceImpl;
//import com.notetakingforeggs.EventsPlatform.service.GoogleCalendarServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Arrays;
import java.util.TimeZone;

public class EventConverter {

    public Event convertToGoogleEvent(AppEvent appEvent) {
        Event event = new Event()
                .setSummary(appEvent.getEventName())
                .setDescription(appEvent.getEventDescription());

        // Convert Unix timestamps to DateTime
        EventDateTime start = new EventDateTime()
                .setDateTime(convertUnixToDateTime(appEvent.getStartDate()))
                .setTimeZone(TimeZone.getDefault().getID());

        EventDateTime end = new EventDateTime()
                .setDateTime(convertUnixToDateTime(appEvent.getEndDate()))
                .setTimeZone(TimeZone.getDefault().getID());

        event.setStart(start);
        event.setEnd(end);

        return event;
    }

    private static DateTime convertUnixToDateTime(long unixTimestamp) {
        return new DateTime(unixTimestamp * 1000L);
    }
}