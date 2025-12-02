# Etapa 1: Construir la aplicación
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copiar proyecto completo
COPY . .

# Dar permisos de ejecución a mvnw
RUN chmod +x mvnw

# Compilar con Maven Wrapper
RUN ./mvnw -q clean package -DskipTests

# Mostrar contenido de target para saber el nombre del JAR
RUN ls -la /app/target


# Etapa 2: Ejecutar la aplicación
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copiar el jar generado
COPY --from=build /app/target/*.jar /app/app.jar

ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]