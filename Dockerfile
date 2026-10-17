#syntax=docker/dockerfile:1.4.3

FROM ubuntu:26.04@sha256:c098726dd9b9733f3e885f8de0ef375206a311b0a317eadc40d347b1115fb944

# Unattended operations
ARG DEBIAN_FRONTEND=noninteractive

# Disable recommended and suggested packages
COPY <<no-recommends <<no-suggests /etc/apt/apt.conf.d/
APT::Install-Recommends "false";
no-recommends
APT::Install-Suggests "false";
no-suggests

# Limit "apt-get upgrade" to security updates
COPY <<security-updates-only /etc/apt/preferences.d/
Package: *
Pin: release a=lucid-security
Pin-Priority: 500

Package: *
Pin: release o=Ubuntu
Pin-Priority: 50
security-updates-only
RUN --mount=type=cache,target=/var/cache/apt \
    apt-get update \
 && apt-get upgrade
