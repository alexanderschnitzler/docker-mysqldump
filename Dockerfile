FROM alpine:3.13.3

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
