package com.notetakingforeggs.EventsPlatform.service.auth;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.Map;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.*;
import com.google.api.client.json.JsonFactory;
import com.notetakingforeggs.EventsPlatform.model.dto.GoogleUserPayloadDTO;
import org.springframework.stereotype.Service;

// This is from here: https://developers.google.com/identity/sign-in/android/backend-auth
// slightly edited
@Service
public class AuthServiceGoogleImpl implements AuthService {

    private final JsonFactory jsonFactory;
    private final HttpTransport transport;
    private final String clientId;
    private final String clientSecret;
    private final ObjectMapper objectMapper;

    public AuthServiceGoogleImpl(JsonFactory jsonFactory, HttpTransport transport, String clientId, String clientSecret, ObjectMapper objectMapper) {
        this.jsonFactory = jsonFactory;
        this.transport = transport;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.objectMapper = objectMapper;
    }

    //TODO this should not just return true/false. Just like this for development and checks. change later
    @Override
    public GoogleUserPayloadDTO validateToken(String token) {

        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
                // Specify the CLIENT_ID of the app that accesses the backend:
                .setAudience(Collections.singletonList(clientId))
                // Or, if multiple clients access the backend:
                //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
                .build();

        // (Receive idTokenString by HTTPS POST)
        try {
            System.out.println("client id : " + clientId);
            System.out.println("token : " + token);
            GoogleIdToken idToken = verifier.verify(token);
            System.out.println("tried verification...");
            if (idToken != null) {
                Payload payload = idToken.getPayload();
                // Print user identifier
                String userId = payload.getSubject();
                System.out.println("User ID: " + userId);

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

    @Override
    public Map<String, String> exctractTokensFromAuthCode(String code) throws GeneralSecurityException, IOException {

        String tokenUrl = "https://oauth2.googleapis.com/token";

        //Exchange the auth code from google for a tokennzzzz
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

        // execute post req - use jackson(?) here to parse response body into tokens etc..
        HttpResponse response = googleRequest.execute();
        String responseBody = response.parseAsString();
        System.out.println(responseBody);

        // extract id token
        JsonNode rootNode = objectMapper.readTree(responseBody);
        String idTokenString = rootNode.path("id_token").asText();
        System.out.println("idtoken:" + idTokenString);
        // TODO encrypt this?
        String refreshtoken = rootNode.path("refresh_token").asText();


        return Map.of(
                "id_token", idTokenString,
                "refresh_token", refreshtoken);
    }
}