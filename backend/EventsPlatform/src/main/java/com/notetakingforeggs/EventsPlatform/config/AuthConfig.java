package com.notetakingforeggs.EventsPlatform.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.oauth2.server.authorization.client.JdbcRegisteredClientRepository;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClientRepository;

import org.springframework.security.oauth2.server.authorization.settings.AuthorizationServerSettings;

import javax.sql.DataSource;

@Configuration
public class AuthConfig {

    @Bean
    RegisteredClientRepository registeredClientRepository(DataSource dataSource){
        return new JdbcRegisteredClientRepository(new JdbcTemplate(dataSource));
    }

    @Bean
    public AuthorizationServerSettings authorizationServerSettings(){
        return AuthorizationServerSettings.builder()
                .issuer("http://localhost:8080")
                .build()
                ;
    }


}
