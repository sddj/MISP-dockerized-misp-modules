FROM python:3.7-slim-buster
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
                ca-certificates \
                git \
                gem \
                curl \
                gosu \
        && apt-get -y autoremove \
        && apt-get -y clean

# Install additional SSL certificates
RUN mkdir -p /usr/local/share/ca-certificates/extra
COPY ca-certs/* /usr/local/share/ca-certificates/extra/
RUN /usr/sbin/update-ca-certificates

#########################################
#       Start of MISP modules Config Part

RUN apt-get update && apt-get install -y \
                python3-dev \
                python3-pip \
                libpq5 \
                libjpeg-dev \
                tesseract-ocr \
                libpoppler-cpp-dev \
                imagemagick \
                libopencv-dev \
                zbar-tools \
                libzbar0 \
                libzbar-dev \
                libfuzzy-dev \
        && apt-get -y autoremove \
        && apt-get -y clean
# 
RUN pip3 install virtualenv

# Add MISP-modules + dependencies
ENV WORKDIR="/usr/local/src/misp-modules"
# Add Argument for MISP-Modules releases
ARG VERSION
# Add Build Variables for gosu
ARG SUDO_WWW="gosu www-data"

# Install MISP Modules
RUN set -e\
        ;mkdir -p /usr/local/src \
        ;chown www-data -R /usr/local/src \
        ;$SUDO_WWW git clone https://github.com/MISP/misp-modules.git ${WORKDIR} \
        ;cd ${WORKDIR} \
        ;[ -n "${VERSION-}" ] && $SUDO_WWW git checkout tags/v${VERSION} \
        ;$SUDO_WWW virtualenv -p python3 ./venv \
        ;$SUDO_WWW ./venv/bin/pip3 install -I -r REQUIREMENTS --no-cache-dir \
        ;$SUDO_WWW ./venv/bin/pip3 install . --no-cache-dir \
        ;$SUDO_WWW ./venv/bin/pip3 install git+https://github.com/abenassi/Google-Search-API --no-cache-dir \
        #;gem install asciidoctor-pdf --pre \
        ;chown -R www-data .

#       End of MISP modules config part
#########################################

# Entrypoint
        COPY files/entrypoint.sh /
        ENTRYPOINT [ "/entrypoint.sh" ]
# Add Healthcheck Config
        COPY files/healthcheck.sh /
        HEALTHCHECK --interval=1m --timeout=45s --retries=3 CMD ["/healthcheck.sh"]
# Change Workdir
        WORKDIR ${WORKDIR}
# Change from root to www-data
        USER www-data
# Expose Port
        EXPOSE 6666


#
#     Variables for Labels:
#
ARG VENDOR="DCSO GmbH"
ARG COMPONENT="misp-modules"
ARG BUILD_DATE
ARG GIT_REPO
ARG VCS_REF
ARG RELEASE_DATE
ARG NAME="MISP-dockerized-${COMPONENT}"
ARG DESCRIPTION="This docker container is part of the DCSO MISP dockerized environment."
ARG DOCUMENTATION="https://github.com/DCSO/MISP-dockerized"
ARG AUTHOR="DCSO MISP Docker Team <misp.docker@dcso.de>"
ARG LICENSE="BSD-3-Clause"

# Environment Variables
ENV VERSION=${VERSION} \
        RELEASE_DATE=${RELEASE_DATE} \
        NAME=${NAME}
#     END Variables

#########################################
LABEL org.label-schema.build-date="${BUILD_DATE}" \
        org.label-schema.name="${NAME}" \
        org.label-schema.description="${DESCRIPTION}" \
        org.label-schema.vcs-ref="${VCS_REF}" \
        org.label-schema.vcs-url="${GIT_REPO}" \
        org.label-schema.url="${GIT_REPO}" \
        org.label-schema.vendor="${VENDOR}" \
        org.label-schema.version="${VERSION}" \
        org.label-schema.usage="${DOCUMENTATION}" \
        org.label-schema.schema-version="1.0.0-rc1"

LABEL   org.opencontainers.image.created="${BUILD_DATE}" \
        org.opencontainers.image.url="${GIT_REPO}" \
        org.opencontainers.image.source="${GIT_REPO}" \
        org.opencontainers.image.version="${VERSION}" \
        org.opencontainers.image.revision="${VCS_REF}" \
        org.opencontainers.image.vendor="${VENDOR}" \
        org.opencontainers.image.title="${NAME}" \
        org.opencontainers.image.description="${DESCRIPTION}" \
        org.opencontainers.image.documentation="${DOCUMENTATION}" \
        org.opencontainers.image.authors="${AUTHOR}" \
        org.opencontainers.image.licenses="${LICENSE}"
#########################################

