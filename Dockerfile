FROM alpine:3.13.2

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
