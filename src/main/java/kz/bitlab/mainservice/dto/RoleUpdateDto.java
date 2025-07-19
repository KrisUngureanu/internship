package kz.bitlab.mainservice.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class RoleUpdateDto {
    private String username;
    private String role;
}
