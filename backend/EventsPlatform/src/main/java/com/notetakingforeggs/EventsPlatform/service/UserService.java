package com.notetakingforeggs.EventsPlatform.service;


import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.model.dto.GoogleUserPayloadDTO;
import com.notetakingforeggs.EventsPlatform.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public interface UserService {

    AppUser getById(Long id);
    List<AppUser> getAll();
    AppUser deleteById(Long id);
    Boolean deleteAll();
    AppUser update(AppUser updatedAppUser, Long id);
    AppUser add(AppUser appUser);
    Boolean existsByGoogleUid(String googleUid);
    AppUser getByGoogleUid(String googleUid);
    AppUser findOrCreateUser(GoogleUserPayloadDTO userPayload, String refreshToken);

}
