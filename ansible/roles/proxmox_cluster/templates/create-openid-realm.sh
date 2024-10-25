#!/usr/bin/env bash

REALM_NAME="{{open_id.realm}}"
REALM_NAME_PRESENT=$(pveum realm list --output-format json | jq -e "map(select(.realm == \"$REALM_NAME\"))[0].realm")

if [[ "$REALM_NAME_PRESENT" != null ]]; then
    pveum realm delete $REALM_NAME
fi

pveum realm add $REALM_NAME --type openid --default true \
    --issuer-url {{open_id.issuer_url}} \
    --client-id {{open_id.client_id}} --client-key {{open_id.client_key}} \
    --username-claim email --autocreate false \
    --comment "Keycloak authentication"

USER_EMAIL="{{open_id.user.email}}"
USER_PRESENT=$(pveum user list --output-format json | jq -e "map(select(.email == \"$USER_EMAIL\"))[0].userid")

if [[ "$USER_PRESENT" == null ]]; then
    pveum user add ${USER_EMAIL}@${REALM_NAME} --email ${USER_EMAIL} --enable true
    pveum acl modify / -user ${USER_EMAIL}@${REALM_NAME} -role Administrator --propagate true
fi
