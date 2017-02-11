# docker-nifi
Creates Docker images for the Apache NiFi Project.

The current image created by this project creates a single-instance NiFi cluster (secure or unsecured), which is useful for development.

## NiFi Versions

1.1.1

## Requirements

- ansible >= 2.2

To install ansible, run `pip install ansible`

## Usage

### Build the Docker Image

**Build an unsecure, single-instance NiFi cluster**

`ansible-playbook unsecure.yml`

**Build a secure, single-instance NiFi cluster**

`ansible-playbook secure.yml`

### Run the Docker Image

`docker run -it -p 8080:8080 -p 9443:9443 --rm --name nifi --hostname nifi nifi`

### Test Running Container

`curl localhost:8080/nifi-api/system-diagnostics`

You should receive a successful response from the server.

Note: Secure installation does not yet respond to the curl request (requires more development).

**Run parameters explained:**

| param | description |
| --- | --- |
| -i | interactive mode |
| -t | allocate a pseudo-TTY |
| -p 8080:8080 | Map local port 8080 to container port 8080 |
| --name nifi | Name the container `nifi` |
| --hostname nifi | Required. hostname on the docker network must be nifi in order for the embedded Zookeeper instance to monitor the node |
