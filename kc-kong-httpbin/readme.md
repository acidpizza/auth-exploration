# Diagram

![Diagram](./diagram.png)

# Credentials
- Keycloak: 
  - admin:admin
  - user1:password
  - user2:password

# See App Cert

0) Default: See Traefik cert.

1) TLS passthrough for Traefik on Kong
- Route to Kong 8000: SSL record too long error
- Route to Kong 8443: Kong termination. See Kong cert.

2) TLS passthrough for Kong: See App cert.

https://konghq.com/blog/tcp-stream-support-kong/

- Route to Kong 5555, Setup Kong Stream Listen on 5555
- Order is important. snis must come before protocols.
```
curl -v -X POST http://localhost:8001/services/httpbin_service/routes -d 'name=httpbin_route' -d 'snis=httpbin.kong.localhost' -d 'protocols=tls'
```
Cant seem to get this to work. Anyway, we do not want TLS passthrough as Kong wont be able to see the headers and do oidc authentication or redirects.


# Subdomain routing

TODO: Figure out how to do regex / subdomain routing for TLS traffic on Traefik. 


# Keycloak

1) Export realm and users
```
/opt/jboss/keycloak/bin/standalone.sh -Dkeycloak.migration.action=export -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.usersExportStrategy=SAME_FILE -Djboss.socket.binding.port-offset=100 -Dkeycloak.migration.file=/tmp/myrealm.json
```

