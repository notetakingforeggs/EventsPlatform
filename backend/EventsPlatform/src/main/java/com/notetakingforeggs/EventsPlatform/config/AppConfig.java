package com.notetakingforeggs.EventsPlatform.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    @Bean
    public HttpTransport httpTransport(){
        return new NetHttpTransport();
    }
    @Bean
    public JacksonFactory jacksonFactory(){
        return new JacksonFactory();
    }
    @Bean
    public ObjectMapper objectMapper(){
        return new ObjectMapper();
    }
    @Bean
    public String baseUrl(){
        return "http://localhost:8080";
    }

}
