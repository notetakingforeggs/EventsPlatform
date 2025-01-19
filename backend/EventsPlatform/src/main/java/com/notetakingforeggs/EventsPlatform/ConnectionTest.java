package com.notetakingforeggs.EventsPlatform;

import java.net.HttpURLConnection;
import java.net.URL;

public class ConnectionTest {
    public static void main(String[] args) {
        try {
            URL url = new URL("https://www.googleapis.com");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}