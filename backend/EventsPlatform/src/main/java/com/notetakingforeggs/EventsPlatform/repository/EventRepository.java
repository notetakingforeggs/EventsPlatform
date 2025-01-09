package com.notetakingforeggs.EventsPlatform.repository;

import com.notetakingforeggs.EventsPlatform.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {
}
