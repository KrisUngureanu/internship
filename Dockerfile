# Используем официальный образ с Java 21 и Gradle
FROM gradle:8.7.0-jdk21 AS build

# Кэшируем зависимости
COPY build.gradle settings.gradle ./
COPY gradle ./gradle
RUN gradle dependencies

# Копируем всё и собираем jar
COPY . .
RUN gradle bootJar

# Отдельный слой для запуска, чтобы сделать образ меньше
FROM eclipse-temurin:21-jre

WORKDIR /app

# Копируем jar из предыдущего слоя
COPY --from=build /home/gradle/build/libs/*.jar app.jar

# Указываем команду запуска
ENTRYPOINT ["java", "-jar", "app.jar"]
