FROM azul/zulu-openjdk:17

LABEL maintainer="Bunna developer"
LABEL app="keycloak-admin"

ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENV TZ=Africa/Addis_Ababa

WORKDIR /app

#COPY target/keycloak-admin-0.0.1-SNAPSHOT.jar app.jar
COPY app.jar app.jar
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
