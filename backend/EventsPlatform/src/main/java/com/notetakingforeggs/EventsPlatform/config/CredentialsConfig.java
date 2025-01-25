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
        String credentialsFilePath = "src/main/resources/credentials.json";
        ObjectMapper mapper = new ObjectMapper();

        try {
            JsonNode rootNode = mapper.readTree(new File(credentialsFilePath));
            return rootNode.path("installed").path("client_id").asText();

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

}
