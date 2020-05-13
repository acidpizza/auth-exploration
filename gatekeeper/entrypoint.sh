#!/bin/bash

# This must be done as root user
echo "Updating CA Trust"
/usr/bin/update-ca-trust

exec /opt/gatekeeper/keycloak-gatekeeper $@
