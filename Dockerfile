# Etapa 1: Build
FROM  maven:3.9.9-eclipse-temurin-21 AS build

# Establece el directorio de trabajo en la imagen de construcción
WORKDIR /app

# Copia el archivo pom.xml y resuelve las dependencias
COPY pom.xml ./
RUN mvn dependency:go-offline

# Copia el código fuente y compila la aplicación
COPY src ./src
RUN mvn clean package -DskipTests

FROM  tomcat:jre21-temurin-noble

# Elimina el contenido predeterminado en la carpeta webapps de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia el archivo WAR generado al directorio de despliegue de Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/app.war

# Expone el puerto predeterminado de Tomcat (8080)
EXPOSE 8080