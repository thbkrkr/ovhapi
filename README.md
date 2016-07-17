# OVH API REPL

## Usage

```
ovhapi_krkr () {
  docker run --rm -ti \
    --env-file $SECRETS/ovhapi-krkr.env \
    -v $(pwd):/play --workdir /play \
    krkr/ovhapi-repl
}
```

```
> ovhapi_krkr

   Hello blurb!

ovhapi > GET /me | jq .address
"In the space"
```
