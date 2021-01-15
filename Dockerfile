FROM alpine:3.13.0

RUN apk add --no-cache mysql-client
ENTRYPOINT ["crond", "-f"]
