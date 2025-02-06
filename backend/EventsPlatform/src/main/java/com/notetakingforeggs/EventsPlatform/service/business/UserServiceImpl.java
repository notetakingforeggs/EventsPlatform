package com.notetakingforeggs.EventsPlatform.service.business;

import com.notetakingforeggs.EventsPlatform.Exception.MissingRefreshTokenException;
import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.model.dto.GoogleUserPayloadDTO;
import com.notetakingforeggs.EventsPlatform.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

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
    public Boolean existsByGoogleUid(String googleUid) {
        return userRepository.existsByGoogleUid(googleUid);
    }

    @Override
    public AppUser getByGoogleUid(String googleUid) {
        return userRepository.getByGoogleUid(googleUid);
    }

    @Override
    public AppUser findOrCreateUser(GoogleUserPayloadDTO userPayload, String refreshToken) {
        System.out.println("Refresh token: " + refreshToken);
        // TODO maybe there is an issue in here? some problem where refresh token became null. maybe just from clearing the db

        String userGoogleId = userPayload.googleUid();
        // New User - if there is no user of the google id create and add user
        if (!existsByGoogleUid(userGoogleId)) {
            if(refreshToken == null || refreshToken.isEmpty()){
                System.out.println("refresh token is coming in null in a new user");
                throw new MissingRefreshTokenException("blank refresh token on a new user?");
            }
            AppUser newAppUser = new AppUser();
            newAppUser.setName(userPayload.name());
            newAppUser.setEmail(userPayload.email());
            newAppUser.setGoogleUid(userPayload.googleUid());
            newAppUser.setRefreshToken(refreshToken);
            return userRepository.save(newAppUser);
        }
        // if there is a user, but there is no refresh token, then it is a sign-in
        else if (refreshToken == null || refreshToken.isBlank()) {
           return userRepository.getByGoogleUid(userGoogleId);
        }
        // otherwise we have a matching googleId, but with a new refresh token, so the user must have cleared connections and we must update refresh token
        else {
            AppUser userToUpdateRefreshToken =  userRepository.getByGoogleUid(userGoogleId);
            userToUpdateRefreshToken.setRefreshToken(refreshToken);
            return userRepository.save(userToUpdateRefreshToken);
        }
    }
}
