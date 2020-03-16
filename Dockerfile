FROM alpine:3.11.3

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
