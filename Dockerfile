#syntax=docker/dockerfile:1.4.3

FROM ubuntu:22.04@sha256:9b8dec3bf938bc80fbe758d856e96fdfab5f56c39d44b0cff351e847bb1b01ea

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
