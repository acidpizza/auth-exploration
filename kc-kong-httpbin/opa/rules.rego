package authz

import input

# Rule to generate token object with member payload field.
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

# Permit "/flasgger_static/*"
allow {
  input.path[0] == "flasgger_static"
  input.method == "GET"
}

# Permit "/spec.json"
allow {
  input.path == ["spec.json"]
  input.method == "GET"
}

# Permit "/headers"
allow {
  input.path == ["headers"]
  input.method == "GET"
}

# Permit "/anything on user1"
allow {
  input.path == ["anything"]
  input.method == "GET"
  token.payload.preferred_username == "user1"
}
