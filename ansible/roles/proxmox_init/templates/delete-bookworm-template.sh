#!/usr/bin/env bash

template_id={{ bookworm_template_id }}

if qm list | grep $template_id -q ; then
    qm destroy $template_id
fi
