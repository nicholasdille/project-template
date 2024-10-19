#syntax=docker/dockerfile:1.4.3

FROM ubuntu:22.04@sha256:0e5e4a57c2499249aafc3b40fcd541e9a456aab7296681a3994d631587203f97

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
