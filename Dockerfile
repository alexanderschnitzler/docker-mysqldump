FROM alpine:3.7

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
