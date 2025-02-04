package com.notetakingforeggs.EventsPlatform.repository;

import com.notetakingforeggs.EventsPlatform.model.Attendee;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AttendeeRepository extends JpaRepository<Attendee, Long> {
}
