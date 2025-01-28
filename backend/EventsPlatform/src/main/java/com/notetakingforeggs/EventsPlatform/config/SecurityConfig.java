package com.notetakingforeggs.EventsPlatform.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.OAuth2LoginDsl;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception{
        http
                .authorizeHttpRequests(authorize -> authorize
//                        .requestMatchers(("/api/v1/oauth2/callback"), ("/redirect-to-google"), ("/public/**") ).permitAll()
//                        .anyRequest().authenticated()
                                .anyRequest().permitAll()
                ).csrf(csrf->csrf.disable())
                .httpBasic(httpBasic->httpBasic.disable())
                .formLogin(formLogin -> formLogin.disable());

                return http.build();
    }
}

/// Define security rules
//  .authorizeHttpRequests(authorize -> authorize
//                .requestMatchers("/api/v1/oauth2/callback", "/redirect-to-google", "/public/**").permitAll() // Allow these routes
//                .anyRequest().authenticated() // Secure all other routes
//            )
//            .oauth2Login() // Enable OAuth2 login for secured routes
//            .and()
//            .csrf().disable(); // Optional: Disable CSRF for APIs (if you're not using forms)
//        return http.build();