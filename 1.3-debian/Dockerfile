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

# Dependencies
# curl for Healthcheck
# git for MISP-modules repository
RUN apt-get update; apt-get install -y \ 
    locales \
    iputils-ping \
    net-tools \
    apt-utils \
    sudo \
    git \
    curl \
    && apt-get autoremove -y && apt-get clean -y

# Set locals
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Install python 3.7 from testing
RUN echo "deb http://cdn-fastly.deb.debian.org/debian testing main" > /etc/apt/sources.list.d/debian-testing.list \
    ; echo 'APT::Default-Release "stable";' | tee -a /etc/apt/apt.conf.d/00local \
    ; apt-get update; apt-get -t testing -y install \
    python3.7 python3.7-dev python3-pip \
    ; apt-get autoremove -y \
    ; apt-get clean -y




#########################################
#       Start of MISP modules Config Part

# From: https://misp.github.io/MISP/INSTALL.ubuntu1804/#initialize-misp-configuration-and-set-some-defaults
RUN apt-get update; apt-get -y install \
    libpq5 libjpeg-dev libfuzzy-dev \
    && apt-get autoremove -y && apt-get clean -y
 
# Install Packages From: 
RUN apt-get update; apt-get -y install \
    #python3-dev  \python3-pip 
    libpq5 libjpeg-dev tesseract-ocr imagemagick ruby-pygments.rb \
    && apt-get autoremove -y && apt-get clean -y

# Change default python to 3.7
# https://unix.stackexchange.com/questions/332641/how-to-install-python-3-6

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 50 \
    ;update-alternatives --install /usr/bin/python python /usr/bin/python2.7 40

RUN cd /usr/local/src/; \
    git clone https://github.com/MISP/misp-modules.git; \
    cd misp-modules; \
    pip3 install -I -r REQUIREMENTS; \
    pip3 install -I .; \
    gem install asciidoctor-pdf --pre


#       End of MISP modules config part
#########################################


#########################################
#       Start of DCSO MISP Config Part

# Environment Variables
    # Environment Variable for Proxy
    ENV http_proxy=""
    ENV https_proxy=""
    ENV no_proxy="0.0.0.0"
    # Version + Name
    ENV NAME ${NAME}
    ENV VERSION ${VERSION}
    ENV RELEASE_DATE ${RELEASE_DATE}



# Entrypoint
COPY files/*.sh /
RUN chmod +x /*.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# Add Healthcheck Config
HEALTHCHECK --interval=1m --timeout=45s --retries=3 CMD ["/healthcheck.sh"]

#       End of DCSO config part
#########################################
