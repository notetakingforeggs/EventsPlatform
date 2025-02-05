package com.notetakingforeggs.EventsPlatform.service.auth;

import com.notetakingforeggs.EventsPlatform.model.dto.GoogleUserPayloadDTO;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Map;

public interface AuthService {

GoogleUserPayloadDTO validateToken(String token);
Map<String,String>  exctractTokensFromAuthCode (String authCode) throws GeneralSecurityException, IOException;
}
