#!/usr/bin/env bash

shopt -s globstar

for filename in ./**/vault.yml; do
    ansible-vault encrypt $filename
done
