package com.notetakingforeggs.EventsPlatform.utils;



import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

import java.io.IOException;

public class GoogleCredentialBuilder {

    private final JsonFactory jsonFactory;
    private final HttpTransport httpTransport;
    private final String clientId;
    private final String clientSecret;

    // Is this unused?
    public GoogleCredentialBuilder(JsonFactory jsonFactory, HttpTransport httpTransport, String clientId, String clientSecret) {
        this.jsonFactory = jsonFactory;
        this.httpTransport = httpTransport;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
    }


    public GoogleCredential buildGoogleCredentials(String refreshToken) throws IOException {
        return new GoogleCredential.Builder()
                .setTransport(httpTransport)
                .setJsonFactory(jsonFactory)
                .setClientSecrets(clientId, clientSecret)
                .build()
                .setRefreshToken(refreshToken);
    }


}
