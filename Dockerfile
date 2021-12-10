FROM tomcat:8.0-alpine

ADD target/myweb.war /usr/local/tomcat/webapps/

EXPOSE 8081
CMD ['catalina.sh","run"]
