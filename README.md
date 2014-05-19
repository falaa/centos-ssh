This is a base image build upon official centos image. During build user and password for ssh connection will be printed. Default username is user but it can be changed in Dockerfile.

When running container, connect volume with authorized_keys file to /srv for key authorization.

# Building
```bash
docker build -t <image name> .
```

# Running
```bash
docker run -d -v <dir with authorized_keys file>/:/srv <image name>
```
