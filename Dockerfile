FROM openjdk:8
EXPOSE 8000
ADD target/my-app-1.0-snapshot.jar my-app-1.0-snapshot.jar
CMD java -classpath src/main/java com.mycompany.app.App
ENTRYPOINT ["java","-jar","/my-app-1.0-snapshot.jar"]
