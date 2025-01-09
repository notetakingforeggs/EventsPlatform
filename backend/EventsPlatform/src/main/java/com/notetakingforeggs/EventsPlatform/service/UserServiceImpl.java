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
    public AppUser getById(Long id) {
        return userRepository.getReferenceById(id);
    }

    @Override
    public List<AppUser> getAll() {
        return userRepository.findAll();
    }

    @Override
    public AppUser deleteById(Long id) {
        AppUser temp = getById(id);
        userRepository.deleteById(id);
        return temp;
    }

    @Override
    public Boolean deleteAll() {
        deleteAll();
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
