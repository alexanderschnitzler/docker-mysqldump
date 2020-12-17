FROM alpine:3.12.3

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
