FROM openjdk:11.0.2
EXPOSE 8000
ADD target/my-app-1.0-snapshot.jar my-app-1.0-snapshot.jar
ENTRYPOINT ["java","-jar","/my-app-1.0-snapshot.jar"]
