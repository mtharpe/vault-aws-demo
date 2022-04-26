#!/usr/bin/env bash

########################
# include the magic
########################
. demo-magic.sh

########################
# OS detection
########################
OSNAME=$(uname)

########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}tharpem${WHITE}:$PWD$ "

# text color
# DEMO_CMD_COLOR=$BLACK

if [ OSNAME eq 'Darwin' ]
then
  open -a "Google Chrome" -n --args --incognito http://localhost:8200
else
  google-chrome --disable-gpu --disable-software-rasterizer --incognito --new-window http://localhost:8200
fi

# hide the evidence
clear

# Start vault demo
pe "vault auth list"
pei ""
pe "vault auth enable aws"
pei ""
pe "vault write auth/aws/config/client access_key=\$AWS_ACCESS_KEY secret_key=\$AWS_SECRET_KEY"
pei ""
pe "vault write auth/aws/role/my-role-iam auth_type=iam bound_iam_principal_arn=arn:aws:iam::$AWS_ACCOUNT_ID:* policies=default token_ttl=30m token_max_ttl=40m"
pei ""
pe "vault write auth/aws/config/client iam_server_id_header_value=demo.vault.example.com"
pei ""
pe "vault policy write default default_policy.hcl"
pei ""
pe "tail default_policy.hcl"
pei ""
pe "vault kv put secret/demo password=vault_demo_password"
pei ""
pe "vault kv get secret/demo"
pei ""
pe "vault kv put secret/classified user=mike password=vault environment=prod type=server"
pei ""
pe "vault kv get secret/classified"
pei ""
pe "vault login -method=aws header_value=demo.vault.example.com role=my-role-iam"
pei ""
pe "vault secrets list"
pei ""
pe "vault kv get secret/demo"
pei ""
pe "vault kv put secret/demo password=vault_demo_password1234"
pei ""
pe "vault kv get secret/demo"
pei ""
pe "vault kv get -version=1 secret/demo"
pei ""
pe "vault kv delete secret/demo"
pei ""
pe "vault kv get secret/classified"
pei ""
pe "vault auth list"
pei ""
pe "rm ~/.vault-token"
pei ""
pe "vault auth list"
pei ""
pe "vault login token=password"
pei ""
pe "vault auth list"
pei ""
pe "vault kv get secret/demo"
pei ""
pe "vault kv delete secret/demo"
pei ""
pe "vault auth disable aws"
pei ""
rm leases.txt
clear
