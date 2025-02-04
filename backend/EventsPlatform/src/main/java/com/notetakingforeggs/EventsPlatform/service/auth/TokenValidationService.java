package com.notetakingforeggs.EventsPlatform.service.auth;

import com.notetakingforeggs.EventsPlatform.model.dto.GoogleUserPayloadDTO;

public interface TokenValidationService {

GoogleUserPayloadDTO validateToken(String token);
}
