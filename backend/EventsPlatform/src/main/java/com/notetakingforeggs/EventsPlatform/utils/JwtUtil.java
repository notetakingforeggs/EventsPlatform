package com.notetakingforeggs.EventsPlatform.utils;


import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;

import java.util.Date;

public class JwtUtil {

    private static final String SECRET_KEY = "secret key put it in credentiatls or something?";
    private static final long EXPIRATION_TIME = 1000 * 60 * 60;

    private static final Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY);

    // Generate JWT
    public static String generateToken(String userID){
        return JWT.create()
                .withSubject(userID)
                .withIssuedAt(new Date())
                .withExpiresAt(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .sign(algorithm);
    }

    // check if token is valid.
    public static DecodedJWT validateToken(String token){
        try{
            JWTVerifier verifier = JWT.require(algorithm).build();
            return verifier.verify(token);
        }catch(JWTVerificationException e ){
            System.out.println("token not validated");
            return null;
        }
    }

}
