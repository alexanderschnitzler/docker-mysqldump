FROM alpine:3.11.6

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
