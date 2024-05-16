#!/bin/sh
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout keycloak_server.key -out keycloak_server.crt -subj "/C=FI/ST=Turku/L=Turku/O=Vaadin/OU=Services/CN=localhost" -addext "subjectAltName = DNS:localhost,DNS:keycloak"
openssl x509 -outform der -in keycloak_server.crt -out keycloak_server.der

chmod 644 keycloak_server.key
