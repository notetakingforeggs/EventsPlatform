package com.notetakingforeggs.EventsPlatform.service.business;

import com.notetakingforeggs.EventsPlatform.model.Attendee;

public interface AttendeeService {
    Attendee becomeAttendee(Long eventId, String userGoogleId);
}
