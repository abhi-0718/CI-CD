FROM tomcat 
WORKDIR webapps 
COPY target/WebApp.jar .
RUN rm -rf ROOT && mv WebApp.jar ROOT.jar
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
