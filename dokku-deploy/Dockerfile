FROM alpine:3.12

RUN apk add --no-cache bash git openssh-client

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
