package com.notetakingforeggs.EventsPlatform.service;


import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public interface UserService {

    AppUser getUserById(Long id);
    List<AppUser> getAllUsers();
    AppUser deleteUserById(Long id);
    Boolean deleteAllUsers();
    AppUser updateAppUser(AppUser updatedAppUser, Long id);
    AppUser addAppUser(AppUser appUser);

}
