# docker-nifi

Creates Docker images for the Apache NiFi Project.

The current image created by this project creates a single-instance NiFi cluster (secure or unsecured), which is useful for development.

## NiFi Versions

1.1.1

## Requirements

- ansible >= 2.2
- openssl
- pexpect

To install ansible, run `pip install ansible`

To install pexpect, run `pip install pexpect`

## Building and running a secure, single-instance NiFi cluster

### Run the ansible playbook, which builds the docker image

`ansible-playbook secure.yml`

### Run the docker container

`docker run -it -p 9443:9443 -p 2222:22 --rm --name nifi --hostname nifi nifi`

**NOTE:** It takes approximately 60 seconds for the NiFi cluster to bootstrap and enter a 'ready'
state.

**Run parameters explained:**

| param | description |
| --- | --- |
| -i | interactive mode |
| -t | allocate a pseudo-TTY |
| -p 9443:9443 | Map local port 9443 to container port 9443 for https access |
| --name nifi | Name the container `nifi` |
| --hostname nifi | Required. hostname on the docker network must be nifi in order for the embedded Zookeeper instance to monitor the node |


### Making secure requests with client certificates

A client certificate is generated for you, which authenticates you to the NiFi cluster. It is
available via two `.p12` files:

`CN=nifi_OU=NIFI.p12`: protected with the generic password `dockernifi`

`CN=nifi_OU=NIFI_unprotected.p12`: unprotected with empty password

**GUI Access**

To use the GUI, add the client certificate to your browser. See your browser's manual for further
instructions on importing client certificates.

Then, navigate to `https://localhost:9443/nifi`

**Curl Example**

`curl --cert CN=nifi_OU=NIFI.p12:dockernifi --cacert nifi-cert.pem https://localhost:9443/nifi-api/tenants/users`

### Adding extra permissions to nifi user

By default, the `nifi` user has limited access to the cluster. To add additional authorizations,
(i.e. view system diagnostics) you must do so through the GUI.

***

## Build an unsecure, single-instance NiFi cluster

`ansible-playbook unsecure.yml`

### Run the Docker Image

`docker run -it -p 8080:8080 --rm --name nifi --hostname nifi nifi`

### Test Running Container

`curl localhost:8080/nifi-api/system-diagnostics`

You should receive a successful response from the server.

**Run parameters explained:**

| param | description |
| --- | --- |
| -i | interactive mode |
| -t | allocate a pseudo-TTY |
| -p 8080:8080 | Map local port 8080 to container port 8080 |
| --name nifi | Name the container `nifi` |
| --hostname nifi | Required. hostname on the docker network must be nifi in order for the embedded Zookeeper instance to monitor the node |
