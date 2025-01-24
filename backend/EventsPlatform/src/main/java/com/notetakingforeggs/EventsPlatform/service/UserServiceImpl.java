package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

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
    public AppUser update(AppUser updatedAppUser, Long id) {
        userRepository.deleteById(id);
        return userRepository.save(updatedAppUser);
    }

    @Override
    public AppUser add(AppUser appUser) {
        return userRepository.save(appUser);
    }

    @Override
    public Boolean existsByUid(String uid){ return userRepository.existsByFirebaseUid(uid);}

    @Override
    public AppUser getByUid(String uid){return userRepository.getByFirebaseUid(uid);}
}

