package com.notetakingforeggs.EventsPlatform.controller;

import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.service.TokenValidationGoogleImpl;
import com.notetakingforeggs.EventsPlatform.service.UserServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/auth")
public class AuthController {


    private final UserServiceImpl userService;
    private final TokenValidationGoogleImpl tokenValidationService;

    public AuthController(UserServiceImpl userService, TokenValidationGoogleImpl tokenValidationService) {
        this.userService = userService;
        this.tokenValidationService = tokenValidationService;
    }


    // Realistically why would i use this? maybe for testing?
//    @GetMapping
//    public ResponseEntity<List<AppUser>> getAllUsers(){
//        List<AppUser> users = userService.getAll();
//        return new ResponseEntity<>(users, HttpStatus.OK);
//    }







    // TODO both of these below methods are redundant. need to initiate GoogleOAUTH Flow from the backend with callbeack endpoint to allow google to send the reresh token directly to the backend
    // google doesn't send refresh  tokens to the front end and persisting access tokens that only last 1 hour is pointless

    @PostMapping("/register-login")
    public ResponseEntity<AppUser> addUser(@RequestBody AppUser appUser, HttpSession httpSession) {
        System.out.println("REGISTER/LOGIN");
        System.out.println(appUser.toString());
        if(!tokenValidationService.validateToken(appUser.getGoogleIdToken())){
            System.out.println("InvalidToken");
            return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);
        }
        // this is jank af - dont do this
        appUser.setGoogleIdToken(null);
        if (!userService.existsByUid(appUser.getFirebaseUid())) {
            AppUser newUser = userService.add(appUser);
            httpSession.setAttribute("userUid", appUser.getFirebaseUid());
            System.out.println("new user registered in db and sesion initialised");
            return new ResponseEntity<>(newUser, HttpStatus.CREATED);
        } else {
            httpSession.setAttribute("userUid", appUser.getFirebaseUid());
            System.out.println("user already logged in, session initialised");
            return new ResponseEntity<>(appUser, HttpStatus.OK);
        }

    }



    @PostMapping("/store-google-token")
    public ResponseEntity<String> storeGoogleToken(@RequestParam String token, HttpSession httpSession) {
        String userUid = httpSession.getAttribute("userUid").toString();
        if (userUid == null) {
            return new ResponseEntity<>("user is not logged in", HttpStatus.BAD_REQUEST);
        }

        // TODO is this going to overwrite, or make another one?
        AppUser currentUser = userService.getByUid(userUid);
        currentUser.setGoogleAccessToken(token);

        userService.add(currentUser);
        return new ResponseEntity<>("token successfully added to user", HttpStatus.OK);
    }

}
