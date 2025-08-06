package kz.bitlab.mainservice.controller;

import jakarta.validation.Valid;
import kz.bitlab.mainservice.dto.*;
import kz.bitlab.mainservice.service.KeycloakService;
import kz.bitlab.mainservice.utils.UserUtils;
import lombok.RequiredArgsConstructor;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping(value = "/user")
@RequiredArgsConstructor
public class UserController {
    private final KeycloakService keycloakService;
    @PostMapping(value = "/create")
    @PreAuthorize("hasRole('ADMIN')")
    public UserRepresentation createUser(@Valid @RequestBody UserCreateDto userCreateDto){
        return keycloakService.createUser(userCreateDto);
    }

    @PostMapping(value = "/sign-in")
    public KeycloakTokenResponse signIn(@RequestBody UserSignInDto userSignInDto){
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

    @PostMapping("/role/assign")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> assignRole(@RequestBody RoleUpdateDto dto) {
        keycloakService.assignRole(dto.getUsername(), dto.getRole());
        return ResponseEntity.ok("Role assigned");
    }

    @PostMapping("/role/remove")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> removeRole(@RequestBody RoleUpdateDto dto) {
        keycloakService.removeRole(dto.getUsername(), dto.getRole());
        return ResponseEntity.ok("Role removed");
    }

    @PutMapping("/me")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> updateMyProfile(@RequestBody UserUpdateDto dto, Authentication authentication) {
        keycloakService.updateProfile(  UserUtils.getCurrentUserName(), dto);
        return ResponseEntity.ok("User updated");
    }
}
