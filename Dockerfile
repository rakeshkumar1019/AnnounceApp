#FROM openjdk:12-alpine

#CMD ["java" , "-jar", "/myweb.war"]

FROM tomcat

COPY /myweb.war /usr/local/tomcat/webapps/
