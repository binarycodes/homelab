TF_DIRS := bootstrap dns github-runner homeassistant kubernetes proxmox proxmox-init static-dns
SHELL := /bin/bash
TF_QUIET_ENV := TF_IN_AUTOMATION=1 TF_CLI_ARGS=-no-color

.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL: # Applies to every targets in the file!
.DEFAULT_GOAL := all-plan

all-init: $(addsuffix -init,$(TF_DIRS))
all-plan: $(addsuffix -plan,$(TF_DIRS))
all-apply: $(addsuffix -apply,$(TF_DIRS))
all-clean: $(addsuffix -clean,$(TF_DIRS))

define tf_targets
.PHONY: $(1)-init $(1)-plan $(1)-apply $(1)-clean $(1)-plan-destroy $(1)-apply-destroy

$(1)-init:
	cd $(1)
	$(TF_QUIET_ENV) terraform init --upgrade

$(1)-plan: $(1)-init
	cd $(1)
	$(TF_QUIET_ENV) terraform plan -out tfplan-$(1)

$(1)-apply: $(1)-plan
	cd $(1)
	$(TF_QUIET_ENV) terraform apply tfplan-$(1)

$(1)-plan-destroy: $(1)-init
	cd $(1)
	$(TF_QUIET_ENV) terraform plan -destroy -out tfplan-$(1)-destroy

$(1)-apply-destroy: $(1)-plan-destroy
	cd $(1)
	$(TF_QUIET_ENV) terraform apply tfplan-$(1)-destroy

$(1)-clean:
	cd $(1)
	rm tfplan*
endef

$(foreach d,$(TF_DIRS),$(eval $(call tf_targets,$(d))))
