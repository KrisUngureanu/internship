package kz.bitlab.mainservice.config;

import io.swagger.v3.oas.models.OpenAPI;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.swagger.v3.oas.models.info.*;

@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI mainServiceOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Main Service API")
                        .version("1.0")
                        .description("Документация LMS-системы MainService: курсы, главы, уроки"));
    }
}
