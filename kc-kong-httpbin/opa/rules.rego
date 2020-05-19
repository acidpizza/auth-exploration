package authz

import input

# Helper to get the token payload.
token = {"payload": payload} {
  [header, payload, signature] := io.jwt.decode(input.token)
}

default allow = false
#default allow = true

# Permit "/"
allow {
  # Use count because the json serializer serializes the empty lua table {} as
  #   a json object instead of array
  count(input.path) == 0
  input.method == "GET"
}

# Permit "/flasgger_static/swagger-ui.css"
allow {
  input.path == ["flasgger_static", "swagger-ui.css"]
  input.method == "GET"
}

# Permit "/spec.json"
allow {
  input.path == ["spec.json"]
  input.method == "GET"
}

# Permit "/anything on user1"
allow {
  input.path == ["anything"]
  input.method == "GET"
  #token.payload.user == "user1"
}

#test[myvar] {
#  myvar:=token.payload
#}
