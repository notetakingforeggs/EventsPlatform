package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.model.AppEvent;
import com.notetakingforeggs.EventsPlatform.repository.EventRepository;
import com.notetakingforeggs.EventsPlatform.service.business.EventServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@SpringBootTest
class EventServiceImplTest {

    // creating mock repository
    @Mock
    EventRepository eventRepository;

    @InjectMocks
    EventServiceImpl eventService;

    @BeforeEach
    public void setUp() {
        AppEvent event1 = new AppEvent();
        event1.setEventName("flying trapeze beginners");
        event1.setStartDate(ZonedDateTime.parse("2025-01-08T10:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event1.setStartDate(ZonedDateTime.parse("2025-01-08T12:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event1.setAttendees(List.of(null));

        AppEvent event2 = new AppEvent();
        event2.setStartDate(ZonedDateTime.parse("2025-01-08T12:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event2.setStartDate(ZonedDateTime.parse("2025-01-08T14:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event2.setEventName("flying trapeze advanced");
        event2.setAttendees(List.of(null));

        AppEvent event3 = new AppEvent();
        event3.setStartDate(ZonedDateTime.parse("2025-01-08T10:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event3.setStartDate(ZonedDateTime.parse("2025-01-08T12:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event3.setEventName("handstands");
        event3.setAttendees(List.of());

        List<AppEvent> eventList1 = List.of(event1, event2, event3);
        List<AppEvent> eventList2 = List.of(event1);
        List<AppEvent> eventList3 = List.of(event1, event3);


        AppUser user1 = new AppUser();
        user1.setName("user1");
        user1.setEmail("jonah@honaj.com");
        user1.setIsStaff(true);
        user1.setEvents(eventList1);

        AppUser user2 = new AppUser();
        user2.setName("user2");
        user2.setEmail("jonah@honaj.com");
        user2.setIsStaff(true);
        user2.setEvents(eventList2);

        AppUser user3 = new AppUser();
        user3.setName("user3");
        user3.setEmail("jonah@honaj.com");
        user3.setIsStaff(true);
        user3.setEvents(eventList3);

        List<AppUser> userList1 = List.of(user1, user2, user3);
        event1.setAttendees(userList1);

        List<AppUser> userList2 = List.of(user1);
        event2.setAttendees(userList2);

        List<AppUser> userList3 = List.of(user1, user3);
        event2.setAttendees(userList3);


    }


    @Test
// testing that when the get all function of the service impl we are calling the method on the repo
    void getAll() {
        // Arrange
        AppEvent event1 = new AppEvent();
        event1.setEventName("flying trapeze beginners");
        event1.setStartDate(ZonedDateTime.parse("2025-01-08T10:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event1.setStartDate(ZonedDateTime.parse("2025-01-08T12:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event1.setAttendees(List.of(null));

        AppEvent event2 = new AppEvent();
        event2.setStartDate(ZonedDateTime.parse("2025-01-08T12:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event2.setStartDate(ZonedDateTime.parse("2025-01-08T14:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event2.setEventName("flying trapeze advanced");
        event2.setAttendees(List.of(null));

        AppEvent event3 = new AppEvent();
        event3.setStartDate(ZonedDateTime.parse("2025-01-08T10:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event3.setStartDate(ZonedDateTime.parse("2025-01-08T12:30:00Z", DateTimeFormatter.ISO_ZONED_DATE_TIME));
        event3.setEventName("handstands");
        event3.setAttendees(List.of());

        List<AppEvent> eventList1 = List.of(event1, event2, event3);
        List<AppEvent> eventList2 = List.of(event1);
        List<AppEvent> eventList3 = List.of(event1, event3);


        AppUser user1 = new AppUser();
        user1.setName("user1");
        user1.setEmail("jonah@honaj.com");
        user1.setIsStaff(true);
        user1.setEvents(eventList1);

        AppUser user2 = new AppUser();
        user2.setName("user2");
        user2.setEmail("jonah@honaj.com");
        user2.setIsStaff(true);
        user2.setEvents(eventList2);

        AppUser user3 = new AppUser();
        user3.setName("user3");
        user3.setEmail("jonah@honaj.com");
        user3.setIsStaff(true);
        user3.setEvents(eventList3);

        List<AppUser> userList1 = List.of(user1, user2, user3);
        event1.setAttendees(userList1);

        List<AppUser> userList2 = List.of(user1);
        event2.setAttendees(userList2);

        List<AppUser> userList3 = List.of(user1, user3);
        event2.setAttendees(userList3);

        when(eventRepository.findAll()).thenReturn(eventList1);
        // Act
        List<AppEvent> events = eventService.getAll();
        // Assert
        verify(eventRepository, times(1)).findAll();

//    assertEquals(); why? make senes idk? jsut checking if the "then return" does what asked? feels pointless.
        assertEquals(events, eventList1);
    }

    @Test
    void getByName() {
    }

    @Test
    void getById() {
    }

    @Test
    void deleteById() {
    }

    @Test
    void update() {
    }

    @Test
    void add() {
    }
}