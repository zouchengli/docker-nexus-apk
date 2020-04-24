ARG NEXUS_VERSION=latest
ARG PACKAGE=nexus-repository-apk-bundle.kar
ARG FORMAT_VERSION=0.0.7
FROM maven:3-jdk-8-alpine AS build
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/main" > /etc/apk/repositories
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/community" >> /etc/apk/repositories
RUN apk add --update \
    wget \
    && rm -rf /var/cache/apk/*
RUN wget https://github.com/zouchengli/docker-nexus-apk/releases/download/0.0.7/nexus-repository-apk-bundle.kar
FROM sonatype/nexus3:$NEXUS_VERSION
MAINTAINER chengli.zou@gmail.com
ARG DEPLOY_DIR=/opt/sonatype/nexus/deploy/
USER root
COPY --from=build ${PACKAGE} ${DEPLOY_DIR}
USER nexus
