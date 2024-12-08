#####

# Etapa 1: Construcción
FROM  maven:3.9.9-eclipse-temurin-21 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto Maven al contenedor
COPY pom.xml ./
COPY src ./src

# Compila la aplicación y genera el JAR
RUN mvn clean package -DskipTests

# Etapa 2: Ejecución
FROM openjdk:21-jdk-slim

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo JAR construido en la etapa 1
COPY --from=build /app/target/*.war app.war

# Expone el puerto de la aplicación
EXPOSE 8080

# Configura el comando de inicio
ENTRYPOINT ["java", "-jar", "app.war"]
