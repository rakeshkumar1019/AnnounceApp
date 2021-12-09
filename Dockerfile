#FROM openjdk:12-alpine

#CMD ["java" , "-jar", "/myweb.war"]

FROM tomcat

COPY *.war /usr/local/tomcat/webapps/
