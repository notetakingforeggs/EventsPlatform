package com.notetakingforeggs.EventsPlatform.utils;

import com.google.api.client.http.*;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.GenericData;

import java.io.IOException;
import java.util.Map;

public class GoogleAuthUtil {

    private final HttpTransport httpTransport;
    private final JacksonFactory jsonFactory;
    private final String TOKEN_URL = "https://oauth2.googleapis.com/token";

    public GoogleAuthUtil(HttpTransport httpTransport, JacksonFactory jsonFactory) {
        this.httpTransport = httpTransport;
        this.jsonFactory = jsonFactory;
    }


    //TODO refactor a bunch of the controller logic into here

    //
    public  String refreshAccessToken(String refreshToken, String clientId, String clientSecret) throws IOException {
        HttpRequestFactory requestFactory = httpTransport.createRequestFactory();

        GenericData data = new GenericData();
        data.put("client_id", clientId);
        data.put("client_secret", clientSecret);
        data.put("refresh_token", refreshToken);
        data.put("grant_type", "refresh_token");

        HttpRequest request = requestFactory.buildPostRequest(new GenericUrl(TOKEN_URL), new UrlEncodedContent(data));
        HttpResponse response = request.execute();

        Map<String, Object> responseMap = jsonFactory.fromInputStream(response.getContent(), Map.class);
        return (String) responseMap.get("access_token");
    }
}
