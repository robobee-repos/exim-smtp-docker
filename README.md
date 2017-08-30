# Exim-SMTP

## Description

SMTP relay and SMTP server based on Exim4.

The image is based on the work
from [namshi/smtp](https://hub.docker.com/r/namshi/smtp/) The image was
modified to run Exim4 as the unprivileged user `Debian-exim` and the
unprivileged port 8025.

## Usage

Because the configuration file `config.autogenerated` must be owned by `root`
and can not be group writable, the configuration file must first be generated
and copied into the docker image. For that, the environment file `env`
is generated by `make` with the following arguments.

| Variable | Description | Example |
| -------- | ----------- | ------- |
| MAILNAME | Container mailname | `work.muellerpublic.de` |
| SMARTHOST_ADDRESS | Smarthost address | `smtp.test` |
| SMARTHOST_PORT | Smarthost port | `22` |
| SMARTHOST_USER | User on the smarthost to send emails | `user` |
| SMARTHOST_PASSWORD | Password of the smarthost user | `password` |
| SMARTHOST_ALIASES | Aliases | `*.muellerpublic.de` |
| RELAY_DOMAINS | Domains that are allowed; separated by a colon `:` | `work.muellerpublic.de:muellerpublic.de` |
| RELAY_NETWORKS | Networks that are allowed; must start with a colon; separated by a colon `:` | `:10.0.0.0/8:172.0.0.0/8` |

```
make build MAILNAME="work.muellerpublic.de" SMARTHOST_ADDRESS="smtp.test" SMARTHOST_PORT="22" SMARTHOST_USER="user" SMARTHOST_PASSWORD="password" SMARTHOST_ALIASES="*.muellerpublic.de" RELAY_DOMAINS="work.muellerpublic.de:muellerpublic.de" RELAY_NETWORKS=":10.0.0.0/8:172.0.0.0/8"
```

## Exposed Ports

| Port | Description |
| ---- | ----------- |
| 8025  | SMTP |

## Test

The docker-compose file `test.yaml` can be used to startup the SMTP container.
The SMTP relay can be then accessed from `localhost:8025`.

```
docker-compose -f test.yaml up
```

The tool `swaks` can be used to test the relay.

```
swaks --to erwin@muellerpublic.de --server localhost:8025
```
