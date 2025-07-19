package kz.bitlab.mainservice.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class UserCreateDto {
    private String email;
    private boolean emailVerified;

    private String username;
    private String firstName;
    private String lastName;
    private String password;


}
