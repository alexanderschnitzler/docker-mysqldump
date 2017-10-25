FROM alpine:3.6

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
