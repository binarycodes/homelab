CREATE DATABASE IF NOT EXISTS {{vault_keycloak.database.name}};
CREATE OR REPLACE USER '{{vault_keycloak.database.user}}' IDENTIFIED BY '{{vault_keycloak.database.password}}';
GRANT ALL PRIVILEGES ON {{vault_keycloak.database.name}}.* TO '{{vault_keycloak.database.user}}';

