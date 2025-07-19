package kz.bitlab.mainservice.service;

import kz.bitlab.mainservice.dto.UserCreateDto;
import kz.bitlab.mainservice.dto.UserSignInDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.ClientResource;
import org.keycloak.admin.client.resource.ClientsResource;
import org.keycloak.representations.idm.ClientRepresentation;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
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

   /* public UserRepresentation createUser(UserCreateDto user){

        UserRepresentation newUser = new UserRepresentation();
        newUser.setEmail(user.getEmail());
        newUser.setEmailVerified(true);
        newUser.setUsername(user.getUsername());
        newUser.setFirstName(user.getFirstName());
        newUser.setLastName(user.getLastName());
        newUser.setEnabled(true);

        CredentialRepresentation credentialRepresentation = new CredentialRepresentation();
        credentialRepresentation.setType(CredentialRepresentation.PASSWORD);
        credentialRepresentation.setValue(user.getPassword());
        credentialRepresentation.setTemporary(false);

        newUser.setCredentials(List.of(credentialRepresentation));
        Response response = keycloak.realm(realm)
                .users()
                .create(newUser);

        if (response.getStatus()!= HttpStatus.CREATED.value()){
            String errorBody = response.readEntity(String.class);  // Это важно!
            log.error("Failed to create user! Status: {}, Body: {}", response.getStatus(), errorBody);
            throw new RuntimeException("Failed to create user! Keycloak error: " + errorBody);
        }

        List<UserRepresentation> searchUsers = keycloak.realm(realm).users().search(user.getUsername());
        var roleUser = keycloak.realm(realm)
                .clients()
                .get(client)
                .roles()
                .get("USER")
                .toRepresentation();


        return searchUsers.get(0);
    }
*/
   public UserRepresentation createUser(UserCreateDto user) {
       // 1. Создаем пользователя
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

       Response response = keycloak.realm(realm).users().create(newUser);
       if (response.getStatus() != HttpStatus.CREATED.value()) {
           String errorBody = response.readEntity(String.class);
           log.error("Failed to create user! Status: {}, Body: {}", response.getStatus(), errorBody);
           throw new RuntimeException("Failed to create user! Keycloak error: " + errorBody);
       }

       // 2. Находим созданного пользователя
       List<UserRepresentation> users = keycloak.realm(realm).users().search(user.getUsername());
       if (users.isEmpty()) {
           throw new RuntimeException("User created but not found");
       }
       UserRepresentation createdUser = users.get(0);

       // 3. Получаем токен администратора
       String token = getAdminAccessToken();

       // 4. Получаем роль USER из realm roles
       String roleUrl = url + "/admin/realms/" + realm + "/roles/USER";
       HttpHeaders headers = new HttpHeaders();
       headers.setBearerAuth(token);
       ResponseEntity<Map> roleResponse = restTemplate.exchange(roleUrl, HttpMethod.GET, new HttpEntity<>(headers), Map.class);

       if (!roleResponse.getStatusCode().is2xxSuccessful() || roleResponse.getBody() == null) {
           throw new RuntimeException("Failed to fetch USER role from Keycloak");
       }

       Map<String, Object> userRole = roleResponse.getBody();

       // 5. Назначаем роль пользователю (realm-level)
       String assignUrl = url + "/admin/realms/" + realm + "/users/" + createdUser.getId() + "/role-mappings/realm";

       List<Map<String, Object>> roles = List.of(Map.of(
               "id", userRole.get("id"),
               "name", userRole.get("name")
       ));

       headers.setContentType(MediaType.APPLICATION_JSON);
       restTemplate.postForEntity(assignUrl, new HttpEntity<>(roles, headers), Void.class);

       return createdUser;
   }




    public String signIn(UserSignInDto userSignInDto){
        String tokenEndPoint = url + "/realms/" + realm + "/protocol/openid-connect/token";
        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("grant_type","password");
        formData.add("client_id",client);
        formData.add("client_secret",clientSecret);
        formData.add("username",userSignInDto.getUsername());
        formData.add("password",userSignInDto.getPassword());
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded");

        ResponseEntity<Map> response = restTemplate.postForEntity(tokenEndPoint, new HttpEntity<>(formData, headers), Map.class);
        Map<String, Object> responseBody = response.getBody();

        if (!response.getStatusCode().is2xxSuccessful() || responseBody == null){
            log.error("Error in signin in");
            throw new RuntimeException("Failed to authenticate");
        }
        return (String) responseBody.get("access_token");
    }


    public Map<String,String> signInSecond(UserSignInDto userSignInDto){
        String tokenEndPoint = url + "/realms/" + realm + "/protocol/openid-connect/token";
        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("grant_type","password");
        formData.add("client_id",client);
        formData.add("client_secret",clientSecret);
        formData.add("username",userSignInDto.getUsername());
        formData.add("password",userSignInDto.getPassword());
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded");

        ResponseEntity<Map> response = restTemplate.postForEntity(tokenEndPoint, new HttpEntity<>(formData, headers), Map.class);
        Map<String, Object> responseBody = response.getBody();

        if (!response.getStatusCode().is2xxSuccessful() || responseBody == null){
            log.error("Error in signin in");
            throw new RuntimeException("Failed to authenticate");
        }
        Map<String,String> resp = new HashMap<>();
        String access_token = (String) responseBody.get("access_token");
        String refresh_token = (String) responseBody.get("refresh_token");
        resp.put("access_token",access_token);
        resp.put("refresh_token",refresh_token);
        return resp;
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
      //  String tokenUrl = url + "/realms/master/protocol/openid-connect/token";
        String tokenUrl = url + "/realms/" + realm + "/protocol/openid-connect/token";
        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("grant_type", "password");
        formData.add("client_id", "admin-cli");
        formData.add("username", adminUsername);
        formData.add("password", adminPassword);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded");

        ResponseEntity<Map> response = restTemplate.postForEntity(tokenUrl, new HttpEntity<>(formData, headers), Map.class);
        return (String) response.getBody().get("access_token");
    }
    public void assignUserRole(String userId) {
        String token = getAdminAccessToken();

        String clientsUrl = url + "/admin/realms/" + realm + "/clients?clientId=" + client;
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        ResponseEntity<List> clientResponse = restTemplate.exchange(clientsUrl, HttpMethod.GET, new HttpEntity<>(headers), List.class);
        if (clientResponse.getBody() == null || clientResponse.getBody().isEmpty()) {
            throw new RuntimeException("Client not found");
        }
        String clientUUID = (String) ((Map) clientResponse.getBody().get(0)).get("id");

        // 2. Получить роль USER
        String roleUrl = url + "/admin/realms/" + realm + "/clients/" + clientUUID + "/roles/USER";
        ResponseEntity<Map> roleResponse = restTemplate.exchange(roleUrl, HttpMethod.GET, new HttpEntity<>(headers), Map.class);
        Map<String, Object> userRole = roleResponse.getBody();

        // 3. Присвоить роль пользователю
        String assignUrl = url + "/admin/realms/" + realm + "/users/" + userId + "/role-mappings/clients/" + clientUUID;
        List<Map<String, Object>> roles = List.of(Map.of(
                "id", userRole.get("id"),
                "name", userRole.get("name")
        ));
        restTemplate.postForEntity(assignUrl, new HttpEntity<>(roles, headers), Void.class);
    }


}
