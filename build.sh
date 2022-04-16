#!/bin/sh
docker buildx build --platform linux/amd64,linux/arm64 -t marimo1110/dovecot:20220416 --no-cache --push .
docker buildx build --platform linux/amd64,linux/arm64 -t marimo1110/dovecot:latest --push .
