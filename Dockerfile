# Etapa 1: Construir la aplicación
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copiar proyecto completo
COPY . .

# Dar permisos de ejecución a mvnw
RUN chmod +x mvnw

# Compilar con Maven Wrapper
RUN ./mvnw -q clean package -DskipTests

# Etapa 2: Ejecutar la aplicación con JDK ligero
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copiar JAR generado
RUN ls -la /app/target
COPY --from=build /app/target/*-SNAPSHOT.jar app.jar

# Render asigna el puerto automáticamente
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]