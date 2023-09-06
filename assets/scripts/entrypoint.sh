#!/bin/bash

# Fill placeholders with env vars
envsubst < /etc/webhook/assets/hooks.yaml > /etc/webhook/assets/filled-hooks.yaml

/usr/local/bin/webhook -verbose -hooks=/etc/webhook/assets/filled-hooks.yaml -hotreload