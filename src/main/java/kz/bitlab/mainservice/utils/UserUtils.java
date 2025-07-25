package kz.bitlab.mainservice.utils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
@Slf4j
public final class UserUtils {
    public static Jwt getCurrentUser(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication instanceof JwtAuthenticationToken){
            return ((JwtAuthenticationToken) authentication).getToken();
        }
        log.warn("Couldn't extract user");
        return null;
    }

    public static String getCurrentUserName(){
        Jwt jwt = getCurrentUser();
        if (jwt != null){
            return jwt.getClaimAsString("preferred_username");
        }
        return null;
    }


}
