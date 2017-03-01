FROM krkr/ovhapi-go-cli

RUN apk --update add curl wget bash git zsh make jq

RUN git clone -q https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh

COPY bin /usr/local/bin
COPY zshrc /root/.zshrc

ENTRYPOINT ["zsh"]