package com.notetakingforeggs.EventsPlatform.repository;

import com.notetakingforeggs.EventsPlatform.model.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<AppUser, Long> {
    Boolean existsByUid(Long Uid);
    AppUser getByUid(Long Uid);
}
