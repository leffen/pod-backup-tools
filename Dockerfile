FROM alpine:3.13

ARG UTILS_USER_GID=1000
ARG UTILS_USER_UID=1000

# BASE
RUN apk --update --clean-protected --no-cache add \
  htop \
  bind-tools \
  wget \
  curl \
  nmap \
  mariadb-client \
  vim \
  openssl \
  bash \
  jq \
  sudo \
  iputils \
  busybox-extras \
  nfs-utils \
  zip \
  p7zip \
  unzip \
  rsync \
  strace \
  mongodb-tools \
  tree \
  redis \
  postgresql \
  apache2-utils \
  git \
  tar \
  gzip \
  curl \
  nano \
  ca-certificates \
  gettext \
  yq \
  && rm -rf /var/cache/apk/*

# GLIBC FOR OC BINARY
ENV LANG=C.UTF-8

# OC and KUBECTL
RUN curl -sLo /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz \
    && tar xzvf /tmp/oc.tar.gz -C /usr/local/bin/ \
    && rm -rf /tmp/oc.tar.gz \
    && chmod +x /usr/local/bin/kubectl


RUN addgroup --gid ${UTILS_USER_GID}  --system utils && \
    adduser -S --uid ${UTILS_USER_UID} -G utils -s /bin/bash utils

ARG TIMEZONE_ARG="Europe/Oslo"
ENV TIMEZONE=$TIMEZONE_ARG

RUN apk add tzdata \
    && echo TIMEZONE: $TIMEZONE > /etc/timezone \
    && cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && apk del tzdata

USER utils
COPY scripts /home/utils/scripts
WORKDIR /home/utils