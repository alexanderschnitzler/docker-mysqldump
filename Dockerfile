FROM alpine:3.11.5

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
