# keycloak-oauth2-proxy

> Project not yet finally tested. Will verify functionality soon.

## About

Inspired by the [OAuth2 Proxy](https://github.com/oauth2-proxy/oauth2-proxy) and the [Keycloak Provider](https://oauth2-proxy.github.io/oauth2-proxy/auth-configuration#keycloak-auth-provider).

## Prerequisites

A suiting client in your Keycloak. Follow [this guide](https://oauth2-proxy.github.io/oauth2-proxy/auth-configuration#keycloak-auth-provider) to create one.

## Building the OCI image

```bash
# build docker image for amd64
docker build -f "Dockerfile-amd64" -t keycloak-oauth2-proxy:0.0.1-amd64 "."
# or armv6
docker build -f "Dockerfile-armv6" -t keycloak-oauth2-proxy:0.0.1-armv6 "."

# or be lazy and pull it from Dockerhub
docker pull hikkoiri/keycloak-oauth2-proxy:0.0.1-amd64
docker pull hikkoiri/keycloak-oauth2-proxy:0.0.1-armv6
```

## Running the image

```bash
# as plain docker container
docker run  \
  -e "CLIENT_ID=$CLIENT_ID" \
  -e "CLIENT_SECRET=$CLIENT_SECRET" \
  -e "KEYCLOAK_HOST=$KEYCLOAK_HOST" \
  -e "REALM=$REALM" \
  -e "KEYCLOAK_GROUP=$KEYCLOAK_GROUP" \
  keycloak-oauth2-proxy:0.0.1-amd64
        

# using docker-compose (enter configurations first in the file)
docker-compose up --build
```

## Open points

- TODO: scribble down configuration sample for fronting nginx reverse proxy
- TODO: write down configuration parameters, expected values + descriptions
- TODO: verify functinality!
- TODO: create dockerhub project and push built images
