FROM openjdk:12-alpine

COPY target/java-jsp-diary-*.war /java-jsp-diary.war

CMD ["java" , "-jar", "/java-jsp-diary.war"]
