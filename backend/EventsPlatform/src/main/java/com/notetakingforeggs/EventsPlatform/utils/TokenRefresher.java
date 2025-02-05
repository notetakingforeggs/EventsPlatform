package com.notetakingforeggs.EventsPlatform.utils;

import com.google.api.client.auth.oauth2.TokenResponse;
import com.google.api.client.googleapis.auth.oauth2.GoogleRefreshTokenRequest;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.notetakingforeggs.EventsPlatform.service.business.UserService;

public class TokenRefresher {
    private final String clientId;
    private final String clientSecret;
    private final UserService userService;

    public TokenRefresher(String clientId, String clientSecret, UserService userService) {
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.userService = userService;
    }


    public String getAccessToken(String googleUserId) {
        try {

            String refreshToken = userService.getByGoogleUid(googleUserId).getRefreshToken();

            TokenResponse response = new GoogleRefreshTokenRequest(
                    new NetHttpTransport(),
                    JacksonFactory.getDefaultInstance(),
                    refreshToken,
                    clientId,
                    clientSecret)
                    .execute();

            String newAccessToken = response.getAccessToken();
            System.out.println("New Access Token: " + newAccessToken);
            return newAccessToken;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}