FROM alpine:latest
RUN apk add --no-cache \
  shellcheck
COPY . /root/.dotfiles
COPY lint/lint.sh /bin/lint.sh
ENTRYPOINT ["/bin/lint.sh"]
