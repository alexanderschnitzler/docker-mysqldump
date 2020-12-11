FROM alpine:3.12.2

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
