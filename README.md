# Supported tags and respective `Dockerfile` links

- [`1.0.1-debian`, `latest`][2]
- [`1.0.0-debian`][1]

[1]: https://github.com/DCSO/MISP-dockerized-misp-modules/blob/master/1.0.0-debian/Dockerfile
[2]: https://github.com/DCSO/MISP-dockerized-misp-modules/blob/master/1.0.1-debian/Dockerfile

# Quick reference

-	**Where to file issues**:  
	[https://github.com/DCSO/MISP-dockerized-misp-modules/issues](https://github.com/DCSO/MISP-dockerized-misp-modules/issues)

-	**Maintained by**:  
	[DCSO](https://github.com/DCSO)

-	**Supported Docker versions**:  
	[the latest release](https://github.com/docker/docker-ce/releases/latest)

# What is MISP dockerized?

**MISP dockerized** is a project designed to provide an easy-to-use and easy-to-install'out of the box' MISP instance that includes everything you need to run MISP with minimal host-side requirements. 

**MISP dockerized** uses MISP (Open Source Threat Intelligence Platform - https://github.com/MISP/MISP), which is maintend and developed by the MISP project team (https://www.misp-project.org/)

### Project Information

| | |
|-|-|
| Travis Master | [![][101]][102] |
| Docker Size & Layers | [![][104]][107]|
| Latest Docker Version | [![][105]][107]|
| Commit for Latest Docker Version | [![][106]][107]|

[101]: https://travis-ci.org/DCSO/MISP-dockerized-misp-modules.svg?branch=master
[102]: https://travis-ci.org/DCSO/MISP-dockerized-misp-modules
[104]: https://images.microbadger.com/badges/image/dcso/misp-dockerized-misp-modules.svg
[105]: https://images.microbadger.com/badges/version/dcso/misp-dockerized-misp-modules.svg
[106]: https://images.microbadger.com/badges/commit/dcso/misp-dockerized-misp-modules.svg
[107]: https://microbadger.com/images/dcso/misp-dockerized-misp-modules




# How to use this image

## Usage

For the Usage please read the [MISP-dockerized](https://github.com/DCSO/MISP-dockerized) Github Repository.


### Using with docker-compose
``` bash
services:
  ### misp-modules ###
  misp-modules:
    image: dcso/misp-dockerized-misp-modules:${misp-modules_CONTAINER_TAG}
    container_name: misp-modules
    restart: on-failure
    networks:
      misp-backend:
        aliases:
          - misp-modules

```

#### .env file for docker-compose variable
If you want to use the misp-modules container with variables you require a .env file with the following content:
``` bash
#=================================================
# ------------------------------
# Hostname
# ------------------------------
HOSTNAME=misp.example.com
# ------------------------------
# Network Configuration
# ------------------------------
DOCKER_NETWORK="192.168.47.0/28"
BRIDGE_NAME="mispbr0"
# ------------------------------
# Container Configuration
# ------------------------------
MISP_MODULES_CONTAINER_TAG=1.0.0-debian-dev
##################################################################
```

### Using with `docker run`
``` bash
docker run \
    --name misp-modules \
    image: dcso/misp-dockerized-MISP_MODULES
    
```


## Documentation
You can also find the [docker file](https://github.com/DCSO/MISP-dockerized-misp-modules/) at Github.


# License

View [license information](https://github.com/DCSO/MISP-dockerized-proxy/blob/master/LICENSE) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

# Contributions

We would say thanks to maker of:
- Mailu
- Mailcow

We have oriented on their docker container to build our ones.