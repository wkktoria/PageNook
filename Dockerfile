FROM maven:3-eclipse-temurin-21 AS build

COPY src /usr/src/app/src
COPY pom.xml /usr/src/app

WORKDIR /usr/src/app

RUN mvn clean package -DskipTests

FROM tomcat:10-jdk21-temurin

RUN sed -i 's/port="8080"/port="8082"/' ${CATALINA_HOME}/conf/server.xml

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /usr/src/app/target/*.war /usr/local/tomcat/webapps/ROOT.war

WORKDIR /usr/local/tomcat

EXPOSE 8082

CMD ["catalina.sh", "run"]