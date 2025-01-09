package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    UserRepository userRepository;

    @Override
    public AppUser getUserById(Long id) {
        return userRepository.getReferenceById(id);
    }

    @Override
    public List<AppUser> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public AppUser deleteUserById(Long id) {
        AppUser temp = getUserById(id);
        userRepository.deleteById(id);
        return temp;
    }

    @Override
    public Boolean deleteAllUsers() {
        deleteAllUsers();
        return true;
    }

    @Override
    public AppUser updateAppUser(AppUser updatedAppUser, Long id) {
        userRepository.deleteById(id);
        return userRepository.save(updatedAppUser);
    }

    @Override
    public AppUser addAppUser(AppUser appUser) {
        return userRepository.save(appUser);
    }
}
