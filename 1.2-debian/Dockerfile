FROM debian:stretch-slim

#     Variables for Labels:
ARG VENDOR="DCSO GmbH"
ARG COMPONENT="misp-modules"
ARG BUILD_DATE
ARG GIT_REPO
ARG VCS_REF
ARG VERSION
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



# Install core components
ENV DEBIAN_FRONTEND noninteractive
#RUN apt-get install -y software-properties- && apt-get autoremove -y && apt-get clean -y

# DCSO Required Software
RUN apt update; apt install -y \ 
    locales \
    iputils-ping \
    net-tools \
    apt-utils \
    sudo \
    git \
    && apt autoremove -y && apt clean -y

# Set locals
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8


#########################################
#       Start of MISP modules Config Part

# Install Packages
RUN sudo apt -y install \
    python3-dev python3-pip libpq5 libjpeg-dev tesseract-ocr imagemagick ruby-pygments.rb \
    && apt-get autoremove -y && apt-get clean -y

RUN cd /usr/local/src/; \
    sudo git clone https://github.com/MISP/misp-modules.git; \
    cd misp-modules; \
    sudo pip3 install -I -r REQUIREMENTS; \
    sudo pip3 install -I .; \
    gem install asciidoctor-pdf --pre


#       End of MISP modules config part
#########################################


#########################################
#       Start of DCSO MISP Config Part

# Environment Variables
    # Environment Variable for Proxy
    ENV HTTP_PROXY=""
    ENV HTTPS_PROXY=""
    ENV NO_PROXY="0.0.0.0"
    # Version + Name
    ENV NAME ${NAME}
    ENV VERSION ${VERSION}

# Entrypoint
COPY files/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# Add Healthcheck Config
#HEALTHCHECK --interval=1m --timeout=45s --retries=3 CMD ["/healthcheck.sh"]

#       End of DCSO config part
#########################################
