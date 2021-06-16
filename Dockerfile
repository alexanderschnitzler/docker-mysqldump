FROM alpine:3.14.0

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
