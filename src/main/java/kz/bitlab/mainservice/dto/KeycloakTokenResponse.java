package kz.bitlab.mainservice.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class KeycloakTokenResponse {
    private String access_token;
    private String refresh_token;

}
