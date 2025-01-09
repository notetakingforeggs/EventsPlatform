package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.AppUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements  UserService{
    @Autowired
    UserService userService;

    @Override
    public AppUser getUserById(Long id) {
        return userService.getUserById(id);
    }

    @Override
    public List<AppUser> getAllUsers() {
        return userService.getAllUsers();
    }

    @Override
    public AppUser deleteUserById(Long id) {
        AppUser temp = getUserById(id);
        userService.deleteUserById(id);
        return temp;
    }

    @Override
    public Boolean deleteAllUsers() {
        deleteAllUsers();
        return true;
    }

    @Override
    public AppUser updateAppUser(AppUser updatedAppUser, Long id) {
        userService.deleteUserById(id);
        return userService.addAppUser(updatedAppUser);
    }

    @Override
    public AppUser addAppUser(AppUser appUser) {
        return userService.addAppUser(appUser);
    }
}
