FROM alpine:3.13

RUN apk add --no-cache \
    mysql-client \
    tzdata
ENTRYPOINT ["crond", "-f"]
