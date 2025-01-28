package com.notetakingforeggs.EventsPlatform.controller;

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.*;
import com.notetakingforeggs.EventsPlatform.model.AppUser;
import com.notetakingforeggs.EventsPlatform.service.TokenValidationGoogleImpl;
import com.notetakingforeggs.EventsPlatform.service.UserServiceImpl;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
    private final String clientId;
    private final String clientSecret;
    private final String baseUrl;


    public AuthController(ClientRegistrationRepository clientRegistrationRepository, HttpTransport httpTransport, String clientId, String clientSecret, String baseUrl) {
        this.clientRegistrationRepository = clientRegistrationRepository;
        this.httpTransport = httpTransport;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.baseUrl = baseUrl;
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
    @GetMapping("/callback")
    public String handleCallback(@RequestParam String code) throws IOException, GeneralSecurityException {

        String tokenUrl = "https://oauth2.googleapis.com/token";

        //Exchange the auth code from google for a tokennzzzz - posting this

        HttpContent content = new UrlEncodedContent(Map.of(
                "code", code,
                "client_id", clientId,
                "client_secret", clientSecret,
                "redirect_uri", baseUrl + "/api/v1/auth/callback",
                "grand_type", "authorization_code"
                ));

        // using googleAPI httptransport to create post request for google api backend
        HttpTransport googleHttpTransport = GoogleNetHttpTransport.newTrustedTransport();
        HttpRequestFactory requestFactory = googleHttpTransport.createRequestFactory();

        GenericUrl url = new GenericUrl(tokenUrl);
        HttpRequest googleRequest = requestFactory.buildPostRequest(url, content);

        // execute post req - use jackson here to parse response body into tokens etc..
        HttpResponse response = googleRequest.execute();
        String responseBody = response.parseAsString();
        return "OAuth2 Flow Completed: " + responseBody;
    }

    @GetMapping("/get-deep-link")
        ResponseEntity<String> getDeepLink(HttpServletResponse response) throws IOException {
            //testing deep linking
            String deepLink = "myapp://junk";
        System.out.println("backend is sending deep link to fronend now-->" + deepLink);
//            response.sendRedirect(deepLink);
        System.out.println("backend returning response entity: ");
            return new ResponseEntity<>(deepLink, HttpStatus.OK);

        }


    // TODO both of these below methods are redundant. need to initiate GoogleOAUTH Flow from the backend with callbeack endpoint to allow google to send the reresh token directly to the backend
    // google doesn't send refresh  tokens to the front end and persisting access tokens that only last 1 hour is pointless

//    @PostMapping("/register-login")
//    public ResponseEntity<AppUser> addUser(@RequestBody AppUser appUser, HttpSession httpSession) {
//        System.out.println("REGISTER/LOGIN");
//        System.out.println(appUser.toString());
//        if(!tokenValidationService.validateToken(appUser.getGoogleIdToken())){
//            System.out.println("InvalidToken");
//            return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);
//        }
//        // this is jank af - dont do this
//        appUser.setGoogleIdToken(null);
//        if (!userService.existsByUid(appUser.getFirebaseUid())) {
//            AppUser newUser = userService.add(appUser);
//            httpSession.setAttribute("userUid", appUser.getFirebaseUid());
//            System.out.println("new user registered in db and sesion initialised");
//            return new ResponseEntity<>(newUser, HttpStatus.CREATED);
//        } else {
//            httpSession.setAttribute("userUid", appUser.getFirebaseUid());
//            System.out.println("user already logged in, session initialised");
//            return new ResponseEntity<>(appUser, HttpStatus.OK);
//        }
//
//    }
//
//
//
//    @PostMapping("/store-google-token")
//    public ResponseEntity<String> storeGoogleToken(@RequestParam String token, HttpSession httpSession) {
//        String userUid = httpSession.getAttribute("userUid").toString();
//        if (userUid == null) {
//            return new ResponseEntity<>("user is not logged in", HttpStatus.BAD_REQUEST);
//        }
//
//        // TODO is this going to overwrite, or make another one?
//        AppUser currentUser = userService.getByUid(userUid);
//        currentUser.setGoogleAccessToken(token);
//
//        userService.add(currentUser);
//        return new ResponseEntity<>("token successfully added to user", HttpStatus.OK);
//    }

}
