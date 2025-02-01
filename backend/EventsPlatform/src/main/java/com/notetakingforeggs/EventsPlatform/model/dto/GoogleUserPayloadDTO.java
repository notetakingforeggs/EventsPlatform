package com.notetakingforeggs.EventsPlatform.model.dto;

public record GoogleUserPayloadDTO(String email,
                                   boolean emailVerified,
                                   String name,
                                   String pictureUrl,
                                   String locale,
                                   String familyName,
                                   String givenName,
                                   String googleUid) {
}
