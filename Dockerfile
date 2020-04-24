ARG NEXUS_VERSION=latest
FROM sonatype/nexus3:$NEXUS_VERSION
MAINTAINER chengli.zou@gmail.com
ARG FORMAT_VERSION=0.0.7
ARG DEPLOY_DIR=/opt/sonatype/nexus/deploy/
USER root
COPY ./nexus-repository-apk-${FORMAT_VERSION}-bundle.kar ${DEPLOY_DIR}
USER nexus
