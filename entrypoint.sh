#!/bin/sh

echo "Start Keycloak OAuth Proxy at $(date)"

echo
echo "Checking if all required environment variables are set"

if [ -z ${CLIENT_ID+x} ]; then
    echo "CLIENT_ID is unset. Exiting";
    exit 1
else
    echo "CLIENT_ID is set"
fi

if [ -z ${CLIENT_SECRET+x} ]; then
    echo "CLIENT_SECRET is unset. Exiting";
    exit 1
else
    echo "CLIENT_SECRET is set"
fi
if [ -z ${KEYCLOAK_HOST+x} ]; then
    echo "KEYCLOAK_HOST is unset. Exiting";
    exit 1
else
    echo "KEYCLOAK_HOST is set"
fi
if [ -z ${REALM+x} ]; then
    echo "REALM is unset. Exiting";
    exit 1
else
    echo "REALM is set"
fi
if [ -z ${KEYCLOAK_GROUP+x} ]; then
    echo "KEYCLOAK_GROUP is unset. Exiting";
    exit 1
else
    echo "KEYCLOAK_GROUP is set"
fi

echo "USE_INSECURE_HTTP is set to $USE_INSECURE_HTTP";
if [ $USE_INSECURE_HTTP = "true" ]; then
    echo "using http for keycloak endpoints. But please reconsider your architectural decisions."
    export PROTOCOL='http'
    elif [ $USE_INSECURE_HTTP = "false" ]; then
    echo "use default https for keycloak endpoints."
    export PROTOCOL='https'
else
    echo "USE_INSECURE_HTTP can only be set to 'true' or 'false'. Exiting"
    exit 1
fi

echo "Preflight check finished. Starting OAuth2 Proxy now:"

/bin/oauth2_proxy \
  -provider=keycloak \
  -client-id=$CLIENT_ID  \
  -client-secret=$CLIENT_SECRET  \
  -login-url="${PROTOCOL}://${KEYCLOAK_HOST}/realms/${REALM}/protocol/openid-connect/auth"  \
  -redeem-url="${PROTOCOL}://${KEYCLOAK_HOST}/realms/${REALM}/protocol/openid-connect/token"  \
  -validate-url="${PROTOCOL}://${KEYCLOAK_HOST}/realms/${REALM}/protocol/openid-connect/userinfo" \
  -keycloak-group=$KEYCLOAK_GROUP