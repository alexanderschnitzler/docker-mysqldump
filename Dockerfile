FROM alpine:3.4

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
