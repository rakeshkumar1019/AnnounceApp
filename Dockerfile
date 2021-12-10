FROM tomcat:8
RUN mv webapps webappsbkp
RUN mv webapps.dist webapps

COPY target/myweb.war /usr/local/tomcat/webapps/myweb.war
