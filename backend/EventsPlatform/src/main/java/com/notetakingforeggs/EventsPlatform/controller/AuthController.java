package com.notetakingforeggs.EventsPlatform.controller;

import com.auth0.jwt.JWT;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.http.*;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.notetakingforeggs.EventsPlatform.Exception.MissingRefreshTokenException;
import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.model.dto.GoogleUserPayloadDTO;
import com.notetakingforeggs.EventsPlatform.service.auth.AuthServiceGoogleImpl;
import com.notetakingforeggs.EventsPlatform.service.business.UserServiceImpl;
import com.notetakingforeggs.EventsPlatform.utils.JwtUtil;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.web.bind.annotation.*;


import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {


//    private final UserServiceImpl userService;
//    private final TokenValidationGoogleImpl tokenValidationService;

    private final ClientRegistrationRepository clientRegistrationRepository;
    private final HttpTransport httpTransport;
    private final JacksonFactory jsonFactory;
    private final String clientId;
    private final String clientSecret;
    private final String baseUrl;
    private final ObjectMapper objectMapper;
    private final UserServiceImpl userService;
    private final AuthServiceGoogleImpl authService;


    public AuthController(ClientRegistrationRepository clientRegistrationRepository, HttpTransport httpTransport, JacksonFactory jsonFactory, String clientId, String clientSecret, String baseUrl, ObjectMapper objectMapper, UserServiceImpl userService, AuthServiceGoogleImpl authService) {
        this.clientRegistrationRepository = clientRegistrationRepository;
        this.httpTransport = httpTransport;
        this.jsonFactory = jsonFactory;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.baseUrl = baseUrl;
        this.objectMapper = objectMapper;
        this.userService = userService;
        this.authService = authService;
    }

    // front end makes a request to this endpoint to initiate OAuth signin/signup flow
    @GetMapping("/redirect-to-google")
    // http servlet is automatically injected by tomcat (servlet container), which is like an abstraction of a bunch of network stuff. In this instance im not just returning data, but redirecting the user to a different part of the network (google log in page)
    // as such i need to leverage to tools that tomcat has, using the "send redirect" method of the httpservlet response named response...
    public ResponseEntity<String> redirectToGoogleOAuth(HttpServletResponse response) throws IOException {
        System.out.println("in the rdr");
        // retrieve the google reg deets
        ClientRegistration googleRegistration = clientRegistrationRepository.findByRegistrationId("google");

        // construct the oauth url
        String redirectUri = googleRegistration.getProviderDetails().getAuthorizationUri() +
                "?client_id=" + googleRegistration.getClientId() +
                "&redirect_uri=" + URLEncoder.encode(googleRegistration.getRedirectUri(), StandardCharsets.UTF_8) +
                "&response_type=code" +
                "&scope=" + URLEncoder.encode(String.join(" ", googleRegistration.getScopes()), StandardCharsets.UTF_8) +
                "&access_type=offline" +
                "&prompt=login";

        // send the redirect to the frontend
        System.out.println(redirectUri);
        return new ResponseEntity<>(redirectUri, HttpStatus.OK);
    }

    // Google api sends the auth code as a query param (i think) to this endpoint which it gets from the above method as "redirect_uri"
    // this method then needs to send the auth code off to a different endpoint (along with a the SAME redirect uri).
    @PostMapping("/token-exchange")
    public ResponseEntity<String> tokenExchange(@RequestParam String code) throws IOException, GeneralSecurityException, FirebaseAuthException {
        System.out.println("Auth Code Received: " + code);

        // Exchaning authcode for tokens and storing in map
        Map<String, String> tokenMap = authService.exctractTokensFromAuthCode(code);


        //Validate user google id Token
        GoogleUserPayloadDTO userPayload = authService.validateToken(tokenMap.get("id_token"));
        if (userPayload != null) {
            System.out.println("token validated!!!!");
            // TODO decide whether to create firebase token for the frontend (why do i need firebase even?)

            // creating new user if none, or getting user info if existing (not currently actually updating anything) TODO implement update
            // needs to update the refresh token if it comes with a refresh token?
            try {
                AppUser currentUser = userService.findOrCreateUser(userPayload, tokenMap.get("refresh_token"));

            // generating JWT for the frontend
            String jwt = JwtUtil.generateToken(currentUser.getGoogleUid());

            // Generate JWT for the frontend
            System.out.println("OUATH flow complete, returning JWT to frontend");
            DecodedJWT exp = JWT.decode(jwt);
            System.out.println(exp);
            return new ResponseEntity<>(jwt, HttpStatus.OK);
            }catch (MissingRefreshTokenException e){
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            System.out.println("Invalid ID token.");
            return new ResponseEntity<>("Failure", HttpStatus.BAD_REQUEST);
        }

    }

    // TODO keep if implementing Firebase for roles? otherwise discard
    public FirebaseToken verifyIdToken(String idToken) throws FirebaseAuthException {
        System.out.println("attempting to verify id token with firebase");
        return FirebaseAuth.getInstance().verifyIdToken(idToken);
    }
}

