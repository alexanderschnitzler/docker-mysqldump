FROM alpine:3.8

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
