package com.notetakingforeggs.EventsPlatform.config;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;
import java.io.IOException;

@Configuration
public class CredentialsConfig {

    @Bean
    public String clientId(){
        // some issues when trying to use path starting with src... maybe needs ../..etc?
        String credentialsFilePath = "/home/jonah/northcoders/grad-post-programme-projects/events-platform/backend/EventsPlatform/src/main/resources/credentials.json";
        ObjectMapper mapper = new ObjectMapper();

        try {
            JsonNode rootNode = mapper.readTree(new File(credentialsFilePath));

            String clientId =  rootNode.path("installed").path("client_id").asText();
            System.out.println(clientId);
            return clientId;

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

}
