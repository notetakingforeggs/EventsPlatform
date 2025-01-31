package com.notetakingforeggs.EventsPlatform.model.dto;

public record newUser(String email, boolean emailVerified, String name, String pictureUrl, String locale) {
}
//  String email = payload.getEmail();
//            boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
//            String name = (String) payload.get("name");
//            String pictureUrl = (String) payload.get("picture");
//            String locale = (String) payload.get("locale");
//            String familyName = (String) payload.get("family_name");
//            String givenName = (String) payload.get("given_name");
//            String googleUid = payload.getSubject();