# Etapa 1: Construir la aplicación
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar proyecto completo
COPY . .

# Compilar con Maven Wrapper
RUN ./mvnw -q clean package -DskipTests

# Etapa 2: Ejecutar la aplicación con JDK ligero
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copiar JAR generado
COPY --from=build /app/target/*.jar app.jar

# Render asigna el puerto automáticamente
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
