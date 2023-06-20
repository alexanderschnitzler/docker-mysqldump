FROM alpine:3.12

RUN apk add --no-cache \
    mysql-client \
    tzdata
ENTRYPOINT ["crond", "-f"]
