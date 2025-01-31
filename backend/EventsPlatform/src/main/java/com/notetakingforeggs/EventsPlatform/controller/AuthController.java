package com.notetakingforeggs.EventsPlatform.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.*;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.service.TokenValidationGoogleImpl;
import com.notetakingforeggs.EventsPlatform.service.UserServiceImpl;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.minidev.json.JSONUtil;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.web.bind.annotation.*;


import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.util.Collections;
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
    private final TokenValidationGoogleImpl tokenValidationGoogle;


    public AuthController(ClientRegistrationRepository clientRegistrationRepository, HttpTransport httpTransport, JacksonFactory jsonFactory, String clientId, String clientSecret, String baseUrl, ObjectMapper objectMapper, UserServiceImpl userService, TokenValidationGoogleImpl tokenValidationGoogle) {
        this.clientRegistrationRepository = clientRegistrationRepository;
        this.httpTransport = httpTransport;
        this.jsonFactory = jsonFactory;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.baseUrl = baseUrl;
        this.objectMapper = objectMapper;
        this.userService = userService;
        this.tokenValidationGoogle = tokenValidationGoogle;
    }

    // front end makes a request to this endpoint to initiate OAuth signin/signup flow
    @GetMapping("/redirect-to-google")
    // http servlet is automatically injected by tomcat (servlet container), which is like an abstraction of a bunch of network stuff. In this instance im not just returning data, but redirecting the user to a different part of the network (google log in page)
    // as such i need to leverage to tools that tomcat has, using the "send redirect" method of the httpservlet response named response...


    public ResponseEntity<String> redirectToGoogleOAuth(HttpServletResponse response) throws IOException {
        System.out.println("in the rdr");
//        // retrieve the google reg deets
        ClientRegistration googleRegistration = clientRegistrationRepository.findByRegistrationId("google");

        // construct the oauth url
        String redirectUri = googleRegistration.getProviderDetails().getAuthorizationUri() +
                "?client_id=" + googleRegistration.getClientId() +
                "&redirect_uri=" + URLEncoder.encode(googleRegistration.getRedirectUri(), StandardCharsets.UTF_8) +
                "&response_type=code" +
                "&scope=" + URLEncoder.encode(String.join(" ", googleRegistration.getScopes()), StandardCharsets.UTF_8) +
                "&access_type=offline";

        // send the redirect to the frontend
        System.out.println("000000000000000000000000000000000");
        System.out.println(redirectUri);
//            response.sendRedirect(redirectUri);


        return new ResponseEntity<>(redirectUri, HttpStatus.OK);
    }

    // Google api sends the auth code as a query param (i think) to this endpoint which it gets from the above method as "redirect_uri"
    // this method then needs to send the auth code off to a different endpoint (along with a the SAME redirect uri).
    @PostMapping ("/token-exchange")
    public String tokenExchange(@RequestParam String code) throws IOException, GeneralSecurityException, FirebaseAuthException {
        System.out.println("Auth Code Received: " + code);
        String tokenUrl = "https://oauth2.googleapis.com/token";

        //Exchange the auth code from google for a tokennzzzz - po
        System.out.println("exchanging code for tokens");
        HttpContent content = new UrlEncodedContent(Map.of(
                "code", code,
                "client_id", clientId,
                "client_secret", clientSecret,
                "grant_type", "authorization_code",
                "redirect_uri", ("https://ludicacid.com")
        ));

        // using googleAPI httptransport to create post request for google api backend
        HttpTransport googleHttpTransport = GoogleNetHttpTransport.newTrustedTransport();
        HttpRequestFactory requestFactory = googleHttpTransport.createRequestFactory();

        GenericUrl url = new GenericUrl(tokenUrl);
        HttpRequest googleRequest = requestFactory.buildPostRequest(url, content);

        // execute post req - use jackson here to parse response body into tokens etc..
        HttpResponse response = googleRequest.execute();
        String responseBody = response.parseAsString();
        System.out.println(responseBody);

        // extract id token
        JsonNode rootNode = objectMapper.readTree(responseBody);
        String idTokenString = rootNode.path("id_token").asText();
        System.out.println("idtoken:" + idTokenString);

        //  Verify Id Token TODO handle exception if token is no good FirebaseAuthException
        if(tokenValidationGoogle.validateToken(idTokenString)){
            System.out.println("token validated!!!!");
        }

        // TODO encrypt this?
        String refreshtoken = rootNode.path("refresh_token").asText();


        // send id token for verification (https://developers.google.com/identity/gsi/web/guides/verify-google-id-token)
        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(httpTransport, jsonFactory)
                // Specify the CLIENT_ID of the app that accesses the backend:
                .setAudience(Collections.singletonList(clientId))
                // Or, if multiple clients access the backend:
                //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
                .build();

        // (Receive idTokenString by HTTPS POST)

        GoogleIdToken googleIdToken = verifier.verify(idTokenString);
        if (googleIdToken != null) {
            Payload payload = googleIdToken.getPayload();

            // Print user identifier
            String userId = payload.getSubject();
            System.out.println("User ID: " + userId);

            // Get profile information from payloadidToken
            String email = payload.getEmail();
            boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
            String name = (String) payload.get("name");
            String pictureUrl = (String) payload.get("picture");
            String locale = (String) payload.get("locale");
            String familyName = (String) payload.get("family_name");
            String givenName = (String) payload.get("given_name");
            String googleUid = payload.getSubject();

            // create firebase token for the frontend



            // create new user (TODO put this function in a util/service class)
            System.out.println(email);
            System.out.println(googleUid);

            AppUser newUser = new AppUser();
            newUser.setName(name);
            newUser.setEmail(email);
            if(refreshtoken!=null) {
                newUser.setRefreshToken(refreshtoken);
            }

            // TODO here make a DTO of the things i might need, then send this off to a "find or create new user" which takes the DTO as a param and does a lookup, creating
            // TODO a new user if one of the Google UID doesnt exist. Change the method below and ignore the autogenned UID (maybe remove?)

            // add user to db and get UID
            AppUser newUserWithUid = userService.add(newUser);
            Long newUserUid = newUserWithUid.getId();
            //

        } else {
            System.out.println("Invalid ID token.");
        }

        return "OAuth2 Flow Completed: " + responseBody;
    }

    public FirebaseToken verifyIdToken(String idToken) throws FirebaseAuthException {
        System.out.println("attempting to verify id token with firebase");
        return FirebaseAuth.getInstance().verifyIdToken(idToken);
    }
}

