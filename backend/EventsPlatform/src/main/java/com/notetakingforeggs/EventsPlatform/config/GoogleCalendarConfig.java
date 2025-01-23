package com.notetakingforeggs.EventsPlatform.config;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.calendar.Calendar;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GoogleCalendarConfig {
    private final HttpTransport httpTransport;
    private final Credential credential;

    public GoogleCalendarConfig(HttpTransport httpTransport, Credential credential) {
        this.httpTransport = httpTransport;
        this.credential = credential;
    }


    @Bean
           public Calendar calendarService() {
        Calendar calendarService = new Calendar.Builder(httpTransport, JacksonFactory.getDefaultInstance(), credential)
                .setApplicationName("why put a name here?")
                .build();
            return calendarService;
    }

}
