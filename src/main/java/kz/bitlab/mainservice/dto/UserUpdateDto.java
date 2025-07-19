package kz.bitlab.mainservice.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class UserUpdateDto {
    private String firstName;
    private String lastName;
    private String email;
    private String newPassword;
}
