package com.notetakingforeggs.EventsPlatform.service.integration;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.DateTime;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.Events;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;
import com.notetakingforeggs.EventsPlatform.model.AppEvent;
import com.google.api.services.calendar.Calendar;
import com.notetakingforeggs.EventsPlatform.service.business.EventService;
import com.notetakingforeggs.EventsPlatform.service.business.UserService;
import com.notetakingforeggs.EventsPlatform.utils.EventConverter;
import com.notetakingforeggs.EventsPlatform.utils.GoogleCredentialsBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;


import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

@Service
public class GoogleCalendarServiceImpl  {

private final HttpTransport httpTransport;
private final JacksonFactory jacksonFactory;
private final String clientId;
private final String clientSecret;
private final UserService userService;
private final EventService eventService;

    public GoogleCalendarServiceImpl(HttpTransport httpTransport, JacksonFactory jacksonFactory, String clientId, String clientSecret, UserService userService, EventService eventService) {
        this.httpTransport = httpTransport;
        this.jacksonFactory = jacksonFactory;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.userService = userService;
        this.eventService = eventService;
    }


    public GoogleCredentials getCreds(String userGoogleId) throws IOException {
        // get refresh token
        String refreshToken = userService.getByGoogleUid(userGoogleId).getRefreshToken();
        System.out.println("REFRESH TOKEN "+ refreshToken);

        // buiild creds
        return new GoogleCredentialsBuilder(clientId, clientSecret).buildGoogleCredentials(refreshToken);
    }




    public Event addEvent(String calendarId, long eventId, String userGoogleId) throws IOException, GeneralSecurityException {

        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        System.out.println("GETTING CREDS");
        GoogleCredentials credentials = getCreds(userGoogleId);

        Event event = new EventConverter().convertToGoogleEvent(eventService.getById(eventId));

            if (calendarId == null) {
                calendarId = "primary";
            }

            try{
                Calendar calendarService = new Calendar.Builder(HTTP_TRANSPORT, jacksonFactory, new HttpCredentialsAdapter(credentials))
                        .setApplicationName("events-platform-e68af")
                        .build();

            calendarService.events().insert(calendarId, event).execute();
            return event;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public List<AppEvent> getEvents(String calendarId, String userGoogleId) throws IOException, GeneralSecurityException {

        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        GoogleCredentials credentials = getCreds(userGoogleId);

        // !!!!!!!!!!! here is where the credentials get fed in. can i just feed in the ones from front end? !!!!!!!!!!!!!!!!!!!
        Calendar service =
                new Calendar.Builder(HTTP_TRANSPORT, jacksonFactory, new HttpCredentialsAdapter(credentials))
                        .setApplicationName("events-platform-e68af")
                        .build();

        // List the next 10 events from the primary calendar.
        DateTime now = new DateTime(System.currentTimeMillis());
        Events events = service.events().list("primary")
                .setMaxResults(10)
                .setTimeMin(now)
                .setOrderBy("startTime")
                .setSingleEvents(true)
                .execute();
        List<Event> items = events.getItems();
        if (items.isEmpty()) {
            System.out.println("No upcoming events found.");
        } else {
            System.out.println("Upcoming events");
            for (Event event : items) {
                DateTime start = event.getStart().getDateTime();
                if (start == null) {
                    start = event.getStart().getDate();
                }
                System.out.printf("%s (%s)\n", event.getSummary(), start);
            }
        }

        return List.of(null);
    }
}
