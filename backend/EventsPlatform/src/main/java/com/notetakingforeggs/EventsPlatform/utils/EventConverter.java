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
            return new DateTime(unixTimestamp * 1000L); // Convert seconds to milliseconds
        }







    // Refer to the Java quickstart on how to setup the environment:
// https://developers.google.com/calendar/quickstart/java
// Change the scope to CalendarScopes.CALENDAR and delete any stored
// credentials.

    // putting it in a method so it can be called

    public Event addEventExample() {

        // Creating new googleEvent
        Event event = new Event()
                .setSummary("Google I/O 2015")
                .setLocation("800 Howard St., San Francisco, CA 94103")
                .setDescription("A chance to hear more about Google's developer products.");
        // Creating DateTime to add set as start
        DateTime startDateTime = new DateTime("2015-05-28T09:00:00-07:00");
        EventDateTime start = new EventDateTime()
                .setDateTime(startDateTime)
                .setTimeZone("America/Los_Angeles");
        event.setStart(start);
        // Creating DateTime to set as end time
        DateTime endDateTime = new DateTime("2015-05-28T17:00:00-07:00");
        EventDateTime end = new EventDateTime()
                .setDateTime(endDateTime)
                .setTimeZone("America/Los_Angeles");
        event.setEnd(end);

        // Setting Re-occurance
        String[] recurrence = new String[]{"RRULE:FREQ=DAILY;COUNT=2"};
        event.setRecurrence(Arrays.asList(recurrence));

        // Creating attendee list to set attendee field
        EventAttendee[] attendees = new EventAttendee[]{
                new EventAttendee().setEmail("lpage@example.com"),
                new EventAttendee().setEmail("sbrin@example.com"),
        };
        event.setAttendees(Arrays.asList(attendees));

        // creating reminders and setting
        EventReminder[] reminderOverrides = new EventReminder[]{
                new EventReminder().setMethod("email").setMinutes(24 * 60),
                new EventReminder().setMethod("popup").setMinutes(10),
        };
        Event.Reminders reminders = new Event.Reminders()
                .setUseDefault(false)
                .setOverrides(Arrays.asList(reminderOverrides));
        event.setReminders(reminders);

        // defining calendar Id, primary is default
        String calendarId = "primary";

        // calling the service method to insert the event, I am changing this from the standard which is below, is this wise?
//        event = service.events().insert(calendarId, event).execute();
//        event = service.addEvent(calendarId, event);
        System.out.printf("Event created: %s\n", event.getHtmlLink());

        //my return
        return event;
    }
}