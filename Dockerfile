FROM alpine:3.12.1

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
