ARG NEXUS_VERSION=3.27.0
ARG PACKAGE=nexus-repository-apk-bundle.kar
FROM alpine AS build
ARG FORMAT_VERSION=0.0.11
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/main" > /etc/apk/repositories
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/community" >> /etc/apk/repositories
RUN apk add --update \
    wget \
    && rm -rf /var/cache/apk/*
RUN wget https://github.com/zouchengli/docker-nexus-apk/releases/download/$FORMAT_VERSION/nexus-repository-apk-bundle.kar
FROM sonatype/nexus3:$NEXUS_VERSION
MAINTAINER chengli.zou@gmail.com
ARG DEPLOY_DIR=/opt/sonatype/nexus/deploy/
USER root
COPY --from=build ${PACKAGE} ${DEPLOY_DIR}
USER nexus
