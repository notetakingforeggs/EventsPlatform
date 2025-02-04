package com.notetakingforeggs.EventsPlatform.repository;

import com.notetakingforeggs.EventsPlatform.model.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<AppUser, Long> {
    Boolean existsByGoogleUid(String Uid);
    AppUser getByGoogleUid(String Uid);
}
