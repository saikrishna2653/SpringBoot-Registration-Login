### vi Dockerfile
# Pull base image 
FROM java:8-jdk-alpine

COPY ./Spring-Full-Security-1.0-SNAPSHOT.war /usr/app/

WORKDIR /usr/app

RUN sh -c 'touch Spring-Full-Security-1.0-SNAPSHOT.war'

ENTRYPOINT ["java","-jar","Spring-Full-Security-1.0-SNAPSHOT.war"]
