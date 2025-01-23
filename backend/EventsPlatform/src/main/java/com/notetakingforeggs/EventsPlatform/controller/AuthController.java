package com.notetakingforeggs.EventsPlatform.controller;

import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.service.UserServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/auth")
public class AuthController {


    private final UserServiceImpl userService;

    public AuthController(UserServiceImpl userService) {
        this.userService = userService;
    }

    // Realistically why would i use this? maybe for testing?
//    @GetMapping
//    public ResponseEntity<List<AppUser>> getAllUsers(){
//        List<AppUser> users = userService.getAll();
//        return new ResponseEntity<>(users, HttpStatus.OK);
//    }


    @PostMapping("/register-login")
    public ResponseEntity<AppUser> addUser(@RequestParam AppUser appUser, HttpSession httpSession) {
        if (!userService.existsByUid(appUser.getUid())) {
            AppUser newUser = userService.add(appUser);
            httpSession.setAttribute("userUid", appUser.getUid());
            System.out.println("new user registered in db and sesion initialised");
        } else {
            httpSession.setAttribute("userUid", appUser.getUid());
            System.out.println("user already logged in, session initialised");
        }
        return new ResponseEntity<>(appUser, HttpStatus.OK);
    }

    @PostMapping("/store-google-token")
    public ResponseEntity<String> storeGoogleToken(@RequestParam String token, HttpSession httpSession){
        Long userUid = (Long)httpSession.getAttribute("userUid");
        if(userUid == null){
            return new ResponseEntity<>("user is not logged in", HttpStatus.BAD_REQUEST);
        }

        // TODO is this going to overwrite, or make another one?
        AppUser currentUser = userService.getByUid(userUid);
        currentUser.setGoogleOAuthToken(token);
        userService.add(currentUser);
        return new ResponseEntity<>("token successfully added to user", HttpStatus.OK);
    }

}
