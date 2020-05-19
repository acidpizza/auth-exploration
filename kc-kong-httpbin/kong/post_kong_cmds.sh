#!/bin/bash

curl -v -X POST http://localhost:8001/services -d 'name=httpbin_service' -d 'url=https://httpbin:8443/'
curl -v -X POST http://localhost:8001/services/httpbin_service/routes -d 'name=httpbin_route' -d 'paths[]=/' -d 'hosts[]=httpbin.kong.localhost'
