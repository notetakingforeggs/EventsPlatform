package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.model.dto.GoogleUserPayloadDTO;
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
    public Boolean existsByGoogleUid(String googleUid){ return userRepository.existsByGoogleUid(googleUid);}

    @Override
    public AppUser getByGoogleUid(String googleUid){return userRepository.getByGoogleUid(googleUid);}

    @Override
    public AppUser findOrCreateUser(GoogleUserPayloadDTO userPayload, String refreshToken) {
        if(!existsByGoogleUid(userPayload.googleUid())){
            AppUser newAppUser = new AppUser();
            newAppUser.setName(userPayload.name());
            newAppUser.setEmail(userPayload.email());
            newAppUser.setGoogleUid(userPayload.googleUid());
            newAppUser.setRefreshToken(refreshToken);

            return userRepository.save(newAppUser);
        }else{
            return getByGoogleUid(userPayload.googleUid());
        }
    }
}
//112271809486897821005
//112271809486897821005
