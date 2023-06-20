FROM alpine:3.11

RUN apk add --no-cache \
    mysql-client \
    tzdata
ENTRYPOINT ["crond", "-f"]
