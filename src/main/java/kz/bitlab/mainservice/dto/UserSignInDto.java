package kz.bitlab.mainservice.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class UserSignInDto {
    private String username;
    private String password;
}
