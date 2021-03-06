REPOSITORY := erwin82
NAME := exim-smtp
VERSION ?= v1.1-1
C_NAME := $(REPOSITORY)/$(NAME)
C_VERSION := v1.0

build: env update-exim4-conf _build ##@targets Builds the docker image.

clean: _clean ##@targets Removes the local docker image.
	rm env
	rm rootfs/config.autogenerated

deploy: _deploy ##@targets Deploys the docker image to the repository.

env:
	$(call check_defined, MAILNAME, Container mailname)
	$(call check_defined, SMARTHOST_ADDRESS, Smarthost address)
	$(call check_defined, SMARTHOST_PORT, Smarthost port)
	$(call check_defined, SMARTHOST_USER, User on the smarthost to send emails)
	$(call check_defined, SMARTHOST_PASSWORD, Password of the smarthost user)
	$(call check_defined, SMARTHOST_ALIASES, Aliases)
	$(call check_defined, RELAY_DOMAINS, Domains that are allowed; separated by a colon :)
	$(call check_defined, RELAY_NETWORKS, Networks that are allowed; must start with a colon; separated by a colon :)
	echo "MAILNAME=$(MAILNAME)" > env
	echo "SMARTHOST_ADDRESS=$(SMARTHOST_ADDRESS)" >> env
	echo "SMARTHOST_PORT=$(SMARTHOST_PORT)" >> env
	echo "SMARTHOST_USER=$(SMARTHOST_USER)" >> env
	echo "SMARTHOST_PASSWORD=$(SMARTHOST_PASSWORD)" >> env
	echo "SMARTHOST_ALIASES=$(SMARTHOST_ALIASES)" >> env
	echo "RELAY_DOMAINS=$(RELAY_DOMAINS)" >> env
	echo "RELAY_NETWORKS=$(RELAY_NETWORKS)" >> env

update-exim4-conf:
	docker run --env-file=env --rm $(C_NAME):$(C_VERSION) bash -cx "/usr/sbin/update-exim4.conf" | tail -n +2 > rootfs/config.autogenerated
.PHONE: update-exim4-conf

include ../utils/Makefile.help
include ../utils/Makefile.functions
include ../utils/Makefile.image

.PHONY +: build clean deploy
