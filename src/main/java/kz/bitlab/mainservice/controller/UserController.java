package kz.bitlab.mainservice.controller;

import kz.bitlab.mainservice.dto.TokenRefreshRequest;
import kz.bitlab.mainservice.dto.UserChangePasswordDto;
import kz.bitlab.mainservice.dto.UserCreateDto;
import kz.bitlab.mainservice.dto.UserSignInDto;
import kz.bitlab.mainservice.service.KeycloakService;
import kz.bitlab.mainservice.utils.UserUtils;
import lombok.RequiredArgsConstructor;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping(value = "/user")
@RequiredArgsConstructor
public class UserController {
    private final KeycloakService keycloakService;
    @PostMapping(value = "/create")
    public UserRepresentation createUser(@RequestBody UserCreateDto userCreateDto){
        return keycloakService.createUser(userCreateDto);
    }

    @PostMapping(value = "/sign-in")
    public Map<String, String> signIn(@RequestBody UserSignInDto userSignInDto){
        return keycloakService.signInSecond(userSignInDto);
    }

    @PostMapping(value = "/change-password")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<String> changePassword(@RequestBody UserChangePasswordDto userChangePasswordDto){
        String currentUserName = UserUtils.getCurrentUserName();
        if (currentUserName == null){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Couldn't identify user");
        }
        try {
            keycloakService.changePassword(currentUserName, userChangePasswordDto.getPassword());
            return ResponseEntity.ok("Password changed");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error on changing password");
        }

    }
    @PostMapping("/refresh")
    public ResponseEntity<Map<String, String>> refresh(@RequestBody TokenRefreshRequest request) {
        Map<String, String> tokens = keycloakService.refreshToken(request.getRefreshToken());
        return ResponseEntity.ok(tokens);
    }

}
