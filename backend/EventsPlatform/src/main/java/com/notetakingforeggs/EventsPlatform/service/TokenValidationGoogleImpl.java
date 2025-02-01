package com.notetakingforeggs.EventsPlatform.service;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;

import java.awt.*;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.Json;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.notetakingforeggs.EventsPlatform.model.dto.GoogleUserPayloadDTO;
import org.springframework.stereotype.Service;

// This is from here: https://developers.google.com/identity/sign-in/android/backend-auth
// slightly edited
@Service
public class TokenValidationGoogleImpl implements TokenValidationService {

    private final JsonFactory jsonFactory;
    private final HttpTransport transport;
    private final String CLIENT_ID;

    public TokenValidationGoogleImpl(JsonFactory jsonFactory, HttpTransport transport, String clientId) {
        this.jsonFactory = jsonFactory;
        this.transport = transport;
        this.CLIENT_ID = clientId;
    }

    //TODO this should not just return true/false. Just like this for development and checks. change later
    @Override
    public GoogleUserPayloadDTO validateToken(String token) {

        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
                // Specify the CLIENT_ID of the app that accesses the backend:
                .setAudience(Collections.singletonList(CLIENT_ID))
                // Or, if multiple clients access the backend:
                //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
                .build();


// (Receive idTokenString by HTTPS POST)
        try {
            System.out.println("client id : " + CLIENT_ID);
            System.out.println("token : " + token);
            GoogleIdToken idToken = verifier.verify(token);
            System.out.println("tried verification...");
            if (idToken != null) {
                Payload payload = idToken.getPayload();
                // Print user identifier
                String userId = payload.getSubject();
                System.out.println("User ID: " + userId);

                // Get profile information from payload
                // TODO put this straight into a DTO
//                String email = payload.getEmail();
//                boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
//                String name = (String) payload.get("name");
//                String pictureUrl = (String) payload.get("picture");
//                String locale = (String) payload.get("locale");
//                String familyName = (String) payload.get("family_name");
//                String givenName = (String) payload.get("given_name");

                // Use or store profile information
                GoogleUserPayloadDTO userPayload = new GoogleUserPayloadDTO(
                        payload.getEmail(),
                        Boolean.valueOf(payload.getEmailVerified()),
                        (String) payload.get("name"),
                        (String) payload.get("picture"),
                        (String) payload.get("locale"),
                        (String) payload.get("family_name"),
                        (String) payload.get("given_name"),
                        payload.getSubject()
                );

                return userPayload;
                // ...

            } else {
                System.out.println("Invalid ID token.");
                return null;
            }
        } catch (IOException e) {
            System.out.println("IO Error in the token validation");
            return null;
        } catch (GeneralSecurityException f) {
            System.out.println("General Secuiryt exception?");
            f.getStackTrace();
        }
        return null;
    }
}