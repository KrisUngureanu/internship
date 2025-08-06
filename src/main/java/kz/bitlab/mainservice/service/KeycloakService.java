package kz.bitlab.mainservice.service;

import kz.bitlab.mainservice.dto.KeycloakTokenResponse;
import kz.bitlab.mainservice.dto.UserCreateDto;
import kz.bitlab.mainservice.dto.UserSignInDto;
import kz.bitlab.mainservice.dto.UserUpdateDto;
import kz.bitlab.mainservice.exception.KeycloakServiceException;
import kz.bitlab.mainservice.exception.UserNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.ClientResource;
import org.keycloak.admin.client.resource.ClientsResource;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.ClientRepresentation;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class KeycloakService {
    private final Keycloak keycloak;
    private final RestTemplate restTemplate;
    @Value("${keycloak.url}")
    private String url;

    @Value("${keycloak.realm}")
    private String realm;

    @Value("${keycloak.client}")
    private String client;

    @Value("${keycloak.client-secret}")
    private String clientSecret;

    @Value("${keycloak.username}")
    private String adminUsername;

    @Value("${keycloak.password}")
    private String adminPassword;

//
    public UserRepresentation createUser(UserCreateDto user) {
        UserRepresentation newUser = createNewUser(user);
        String token = getAdminAccessToken();
        String roleId = getUserRole(token);
        assignRoleToUser(newUser, roleId, token);
        return newUser;
    }

    private UserRepresentation createNewUser(UserCreateDto user) {
        UserRepresentation newUser = new UserRepresentation();
        newUser.setEmail(user.getEmail());
        newUser.setEmailVerified(true);
        newUser.setUsername(user.getUsername());
        newUser.setFirstName(user.getFirstName());
        newUser.setLastName(user.getLastName());
        newUser.setEnabled(true);
        CredentialRepresentation credential = new CredentialRepresentation();
        credential.setType(CredentialRepresentation.PASSWORD);
        credential.setValue(user.getPassword());
        credential.setTemporary(false);
        newUser.setCredentials(List.of(credential));

        Response response = getKeycloakUsers().create(newUser);
        if (response.getStatus() != HttpStatus.CREATED.value()) {
            String errorBody = response.readEntity(String.class);
            log.error("Failed to create user! Status: {}, Body: {}", response.getStatus(), errorBody);
            throw new KeycloakServiceException("Failed to create user! Keycloak error: " + errorBody);
        }
        return newUser;
    }

    private String getUserRole(String token) {
        String roleUrl = url + "/admin/realms/" + realm + "/roles/USER";
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        ResponseEntity<Map> roleResponse = restTemplate.exchange(roleUrl, HttpMethod.GET, new HttpEntity<>(headers), Map.class);

        if (!roleResponse.getStatusCode().is2xxSuccessful() || roleResponse.getBody() == null) {
            throw new KeycloakServiceException("Failed to fetch USER role from Keycloak");
        }
        Map<String, Object> userRole = roleResponse.getBody();
        return (String) userRole.get("id");
    }

    private void assignRoleToUser(UserRepresentation newUser, String roleId, String token) {
        String assignUrl = url + "/admin/realms/" + realm + "/users/" + newUser.getId() + "/role-mappings/realm";
        List<Map<String, Object>> roles = List.of(Map.of("id", roleId));
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        restTemplate.postForEntity(assignUrl, new HttpEntity<>(roles, headers), Void.class);
    }



    public KeycloakTokenResponse signInSecond(UserSignInDto userSignInDto) {
        String tokenEndPoint = url + "/realms/" + realm + "/protocol/openid-connect/token";
        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("grant_type", "password");
        formData.add("client_id", client);
        formData.add("client_secret", clientSecret);
        formData.add("username", userSignInDto.getUsername());
        formData.add("password", userSignInDto.getPassword());

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded");

        ResponseEntity<KeycloakTokenResponse> response = restTemplate.postForEntity(tokenEndPoint, new HttpEntity<>(formData, headers), KeycloakTokenResponse.class);
        KeycloakTokenResponse responseBody = response.getBody();

        if (responseBody == null || !response.getStatusCode().is2xxSuccessful()) {
            log.error("Error signing in");
            throw new KeycloakServiceException("Failed to authenticate");
        }

        return responseBody;
    }



    public void changePassword(String username, String newPassword){
        List<UserRepresentation> users = keycloak
                .realm(realm)
                .users()
                .search(username);
        if (users.isEmpty()){
            log.error("User not found to change");
            throw new RuntimeException("User not found to change");
        }
        UserRepresentation userRepresentation = users.get(0);

        CredentialRepresentation credentialRepresentation = new CredentialRepresentation();
        credentialRepresentation.setType(CredentialRepresentation.PASSWORD);
        credentialRepresentation.setValue(newPassword);
        credentialRepresentation.setTemporary(false);
        keycloak
                .realm(realm)
                .users()
                .get(userRepresentation.getId())
                .resetPassword(credentialRepresentation);

        log.info("Password changed");
    }

    public Map<String, String> refreshToken(String refreshToken) {
        String tokenEndpoint = url + "/realms/" + realm + "/protocol/openid-connect/token";

        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("grant_type", "refresh_token");
        formData.add("client_id", client);
        formData.add("client_secret", clientSecret);
        formData.add("refresh_token", refreshToken);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded");

        ResponseEntity<Map> response = restTemplate.postForEntity(tokenEndpoint, new HttpEntity<>(formData, headers), Map.class);
        Map<String, Object> responseBody = response.getBody();

        if (!response.getStatusCode().is2xxSuccessful() || responseBody == null) {
            log.error("Failed to refresh token");
            throw new RuntimeException("Could not refresh token");
        }

        Map<String, String> result = new HashMap<>();
        result.put("access_token", (String) responseBody.get("access_token"));
        result.put("refresh_token", (String) responseBody.get("refresh_token"));
        return result;
    }


    public String getAdminAccessToken() {
        String tokenUrl = url + "/realms/" + realm + "/protocol/openid-connect/token";
        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("grant_type", "password");
        formData.add("client_id", "admin-cli");
        formData.add("username", adminUsername);
        formData.add("password", adminPassword);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded");

        ResponseEntity<Map> response = restTemplate.postForEntity(tokenUrl, new HttpEntity<>(formData, headers), Map.class);
        Map<String, String> responseBody = response.getBody();

        if (responseBody == null || !response.getStatusCode().is2xxSuccessful()) {
            log.error("Failed to get admin access token");
            throw new KeycloakServiceException("Failed to get admin access token");
        }

        String accessToken = responseBody.get("access_token");
        if (accessToken == null) {
            log.error("Access token is null");
            throw new KeycloakServiceException("Access token is null");
        }
        return accessToken;
    }



    public void assignRole(String username, String roleName) {

        var clientId = keycloak.realm(realm).clients().findByClientId(client).get(0).getId();
        var role = keycloak.realm(realm).clients().get(clientId).roles().get(roleName).toRepresentation();
        UserRepresentation user = getUser(username);
        getKeycloakUsers().get(user.getId()).roles().clientLevel(clientId).add(List.of(role));
    }

    public void removeRole(String username, String roleName) {
        UserRepresentation user = getUser(username);
        var clientId = keycloak.realm(realm).clients().findByClientId(client).get(0).getId();
        var role = keycloak.realm(realm).clients().get(clientId).roles().get(roleName).toRepresentation();

        getKeycloakUsers().get(user.getId()).roles().clientLevel(clientId).remove(List.of(role));
    }

    public void updateProfile(String username, UserUpdateDto dto) {
        List<UserRepresentation> users = getUserFromUsername(username);
        if (users.isEmpty()) throw new RuntimeException("User not found");

        var user = users.get(0);
        if (dto.getFirstName() != null) user.setFirstName(dto.getFirstName());
        if (dto.getLastName() != null) user.setLastName(dto.getLastName());
        if (dto.getEmail() != null) user.setEmail(dto.getEmail());

        getKeycloakUsers().get(user.getId()).update(user);

        if (dto.getNewPassword() != null && !dto.getNewPassword().isEmpty()) {
            CredentialRepresentation newPass = new CredentialRepresentation();
            newPass.setType(CredentialRepresentation.PASSWORD);
            newPass.setValue(dto.getNewPassword());
            newPass.setTemporary(false);
            getKeycloakUsers().get(user.getId()).resetPassword(newPass);
        }
    }


    private UsersResource getKeycloakUsers(){
       return keycloak.realm(realm).users();
    }
    private List<UserRepresentation> getUserFromUsername(String username){
        return getKeycloakUsers().search(username);
    }

    private UserRepresentation getUser(String username){
        List<UserRepresentation> users = getUserFromUsername(username);
        if (users.isEmpty()) {
            throw new UserNotFoundException("User not found: " + username);
        }
        return users.get(0);
    }


}
