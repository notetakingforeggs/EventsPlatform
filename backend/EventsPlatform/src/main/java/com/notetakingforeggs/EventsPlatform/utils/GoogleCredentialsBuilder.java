package com.notetakingforeggs.EventsPlatform.utils;



import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.UserCredentials;

import java.io.IOException;

public class GoogleCredentialsBuilder {
    private final String clientId;
    private final String clientSecret;

    // Is this unused?
    public GoogleCredentialsBuilder(String clientId, String clientSecret) {
        this.clientId = clientId;
        this.clientSecret = clientSecret;
    }


    public GoogleCredentials buildGoogleCredentials(String refreshToken) throws IOException {
        return UserCredentials.newBuilder()
                .setClientId(clientId)
                .setClientSecret(clientSecret)
                .setRefreshToken(refreshToken)
                .build();

    }


}
