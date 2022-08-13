FROM alpine:3.12

COPY bin/echo-all /usr/local/bin/echo-all

CMD ["/usr/local/bin/echo-all"]
