FROM alpine:3.17

RUN apk add --no-cache \
    mysql-client \
    tzdata
ENTRYPOINT ["crond", "-f"]
