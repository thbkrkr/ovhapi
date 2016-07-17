FROM krkr/ovhapi-go-cli

RUN apk --update add bash git zsh make jq

COPY bin /usr/local/bin

COPY zshrc /root/.zshrc

ENTRYPOINT ["zsh"]