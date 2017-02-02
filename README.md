# docker-nifi
Creates Docker images for the Apache NiFi Project.

The current image created by this project creates a single-instance NiFi cluster (unsecured), which is useful for development.

## NiFi Versions

1.1.1

## Usage

### Build

`docker build -t nifi .`

### Run

`docker run -it -p 8080:8080 -p 9443:9443 --rm --name nifi --hostname nifi nifi`

**Run parameters:**

| param | description |
| --- | --- |
| -i | interactive mode |
| -t | allocate a pseudo-TTY |
| -p 8080:8080 | Map local port 8080 to container port 8080 |
| --name nifi | Name the container `nifi` |
| --hostname nifi | Required. hostname on the docker network must be nifi in order for the embedded Zookeeper instance to monitor the node |
