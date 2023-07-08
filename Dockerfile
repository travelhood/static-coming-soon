FROM debian:12-slim AS builder

WORKDIR /app

RUN apt update \
    && apt install -y wget unzip

RUN wget https://github.com/m3ng9i/ran/releases/download/v0.1.6/ran_linux_amd64.zip \
    && unzip ran_linux_amd64.zip \
    && rm -f ran_linux_amd64.zip

FROM busybox

WORKDIR /app
COPY --from=builder /app/ran_linux_amd64 /app/ran
COPY ./public ./public

EXPOSE 8080

ENTRYPOINT ["/app/ran", "-r=/app/public", "-p=8080"]
