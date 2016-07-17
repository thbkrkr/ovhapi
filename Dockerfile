FROM alpine:3.4

RUN apk --no-cache add bash jq curl openssl git
COPY bin /usr/local/bin

COPY bashrc /root/.bashrc

ENTRYPOINT ["/usr/local/bin/dops-spawner"]