FROM alpine:3.14

RUN apk add --no-cache \
    mysql-client \
    tzdata
ENTRYPOINT ["crond", "-f"]
