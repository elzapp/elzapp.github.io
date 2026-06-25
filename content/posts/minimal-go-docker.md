---
title: "Prune your Go docker image"
date: 2020-08-07T20:23:37+02:00
draft: true
tags:
  - "Go"
  - "Docker"
  - "Security"
  - "Green computing"
  - "Kubernetes"
  - "Cloud"
summary: Speed up your deploys and reduce your attack surface by running your Go code in Docker with the absolute minimum of overhead
---
Speed up your deploys and reduce your attack surface by running your Go code in Docker with the absolute minimum of overhead.

When building Docker images for Go applications, it seems natural to use the official golang Docker images.

It even works great, until your operations person comes to you with some qualys-scan report that the pen-testers ran, asking you what we're going to do with [that BASH vulnerability](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18276).

Then you realize, why do we even have bash on that image? - And what other stuff is on there that you don't need?

Go creates statically* compiled ELF binaries, that require very little to be present in the environment other than what's provided by the Linux kernel.


Here is the full Dockerfile:

```Dockerfile
FROM golang:1.14.6-alpine3.12 AS build
RUN adduser --disabled-password --gecos "" --home "/app" --no-create-home --uid "1231" "app" "app"
RUN mkdir /src
RUN mkdir /app
COPY ./src/ /src/
WORKDIR /src/lbcheck
RUN touch /app/lbcheck.yaml
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /app/myapp


FROM scratch AS final
COPY --from=build /etc/passwd /etc/group /etc/
COPY --from=build /app/* /app/
WORKDIR /app
USER app
EXPOSE 8080
ENTRYPOINT ["/app/lbcheck"]
```
