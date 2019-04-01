FROM alpine:3.9

#     Variables for Labels:
ARG VENDOR="DCSO GmbH"
ARG COMPONENT="misp-modules"
ARG BUILD_DATE
ARG GIT_REPO
ARG VCS_REF
ARG VERSION
ARG RELEASE_DATE
ARG NAME="MISP-dockerized-${COMPONENT}"
ARG DESCRIPTION="This docker container is part of the DCSO MISP dockerized environment."
ARG DOCUMENTATION="https://github.com/DCSO/MISP-dockerized"
ARG AUTHOR="DCSO MISP Docker Team <misp.docker@dcso.de>"
ARG LICENSE="BSD-3-Clause"
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


#########################################
#       Start of MISP modules Config Part


# Install dependencies
#       zlib-dev for pip3 pillow
#       curl for healthcheck: curl -fk 0.0.0.0:6666|| exit 1
#       g++ to install packages
#       ruby-rdoc for gem install asciidoctor-pdf --pre

RUN apk --no-cache add \
        sudo \
        git \
        g++ \
        python3-dev \
        libjpeg-turbo-dev \
        tesseract-ocr \
        imagemagick \
        ruby-pygments \
        libpq \
        linux-headers \
        zlib-dev \
        curl \
        ruby-rdoc \
        ;

RUN git clone https://github.com/MISP/misp-modules.git /usr/local/src/misp-modules \
     ;cd /usr/local/src/misp-modules \
     ;sudo pip3 install -I -r REQUIREMENTS --no-cache-dir \
     ;sudo pip3 install -I . --no-cache-dir \
     ;gem install asciidoctor-pdf --pre \
     ;
#       End of MISP modules config part
#########################################


#########################################
#       Start of DCSO MISP Config Part

# Change workdir
WORKDIR /usr/local/src/misp-modules

# Entrypoint
COPY files/entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]

# Add Healthcheck Config
COPY files/healthcheck.sh /
HEALTHCHECK --interval=1m --timeout=45s --retries=3 CMD ["/healthcheck.sh"]

# Environment Variable for Proxy
ENV http_proxy=""
ENV https_proxy=""
ENV no_proxy="0.0.0.0"

# Environment Variable to check Version
# Version + Name
ENV NAME ${NAME}
ENV VERSION ${VERSION}
ENV RELEASE_DATE ${RELEASE_DATE}
