FROM debian:stable-slim

#     Variables:
# for Labels:
ARG VENDOR="DCSO GmbH <www.dcso.de>"
ARG BUILD_DATE
ARG NAME="misp-modules"
ARG GIT_REPO
ARG VCS_REF
ARG VERSION
#     END Variables

#############################################
LABEL org.label-schema.build-date="${BUILD_DATE}" \
          org.label-schema.name="MISP-dockerized-${NAME}" \
          org.label-schema.description="This docker container is part of the DCSO MISP dockerized environment." \
          org.label-schema.vcs-ref="${VCS_REF}" \
          org.label-schema.vcs-url="${GIT_REPO}" \
          org.label-schema.vendor="${VENDOR}" \
          org.label-schema.version="${VERSION}" \
          org.label-schema.schema-version="1.0.0-rc1"
################################################

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
    python3-dev python3-pip libpq5 libjpeg-dev

RUN cd /usr/local/src/; \
    sudo git clone https://github.com/MISP/misp-modules.git; \
    cd misp-modules; \
    sudo pip3 install -I -r REQUIREMENTS; \
    sudo pip3 install -I .;


#       End of MISP modules config part
#########################################


#########################################
#       Start of DCSO MISP Config Part

# Environment Variables
    # Environment Variable for Proxy
    ENV HTTP_PROXY=""
    ENV HTTPS_PROXY=""
    ENV NO_PROXY="0.0.0.0"


# Entrypoint
COPY files/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# Add Healthcheck Config
#HEALTHCHECK --interval=1m --timeout=45s --retries=3 CMD ["/healthcheck.sh"]

#       End of DCSO config part
#########################################
