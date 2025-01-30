package com.notetakingforeggs.EventsPlatform.config;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;
import java.io.IOException;

@Configuration
public class CredentialsConfig {

    private final ObjectMapper objectMapper;
    //    private final String  credentialsFilePath  = "/src/main/resources/credentials-with-backend-client-id.json";
//    private final String  credentialsFilePath  = "/home/jonah/northcoders/grad-post-programme-projects/events-platform/backend/EventsPlatform/src/main/resources/credentials-with-backend-client-id.json";
    private final String credentialsFilePath = "/home/jonah/northcoders/grad-post-programme-projects/events-platform/backend/EventsPlatform/src/main/resources/credentials/credentials-web-newsecret.json";


    public CredentialsConfig(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    @Bean
    public String clientId() {
        // some issues when trying to use path starting with src... maybe needs ../..etc?
        try {
            JsonNode rootNode = objectMapper.readTree(new File(credentialsFilePath));
            String clientId = rootNode.path("installed").path("client_id").asText();
            System.out.println(clientId);
            return clientId;

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Bean
    public String clientSecret() {

        try {
            JsonNode rootNode = objectMapper.readTree(new File(credentialsFilePath));
            return rootNode.path("installed").path("client_secret").asText();
        } catch (IOException e) {
            System.out.println("deal with this exception better - issue with client secret bean in credconfig");
        }
        return null;
    }

}
