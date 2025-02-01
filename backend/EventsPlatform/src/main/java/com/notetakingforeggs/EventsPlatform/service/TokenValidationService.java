package com.notetakingforeggs.EventsPlatform.service;

import com.notetakingforeggs.EventsPlatform.model.dto.GoogleUserPayloadDTO;

public interface TokenValidationService {

GoogleUserPayloadDTO validateToken(String token);
}
