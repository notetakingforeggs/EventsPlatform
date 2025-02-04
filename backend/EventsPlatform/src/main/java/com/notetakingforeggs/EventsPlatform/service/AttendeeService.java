package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.Attendee;

public interface AttendeeService {
    Attendee becomeAttendee(Long eventId, String userGoogleId);
}
