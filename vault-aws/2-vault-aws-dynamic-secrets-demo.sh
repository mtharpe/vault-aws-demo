#!/usr/bin/env bash

########################
# include the magic
########################
. ../demo-magic.sh

########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=1000

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}tharpem${WHITE}:$PWD$ "

# text color
# DEMO_CMD_COLOR=$BLACK

# hide the evidence
clear

# Start vault demo
pe "vault secrets list"
pei ""
pe "vault secrets enable aws"
pei ""
pe "vault write aws/config/lease lease=30m lease_max=30m"
pei ""
pe "vault write aws/config/root access_key=\$AWS_ACCESS_KEY secret_key=\$AWS_SECRET_KEY region=us-east-1"
pe ""
pei "vault write aws/roles/my-role credential_type=iam_user policy_document=-<<EOF
{
  \"Version\": \"2012-10-17\",
  \"Statement\": [
    {
      \"Sid\": \"Stmt1426528957000\",
      \"Effect\": \"Allow\",
      \"Action\": [
        \"ec2:*\"
      ],
      \"Resource\": [
        \"*\"
      ]
    }
  ]
}
EOF"
pe "aws iam list-users"
pei ""
vault read aws/creds/my-role > /dev/null
p "vault read aws/creds/my-role"
echo "Key                Value
---                -----
lease_id           aws/creds/my-role/U6BzIXYTcV6rdxh2AFmXxb29
lease_duration     30m
lease_renewable    true
access_key         AKIAZDDZU7NNXFECDFST
secret_key         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
security_token     <nil>"
pei ""
pe "aws iam list-users"
pei ""
pe "vault list sys/leases/lookup/aws/creds/my-role"
vault list sys/leases/lookup/aws/creds/my-role > leases.txt
pei ""
pe "vault lease revoke aws/creds/my-role/$(tail -1 leases.txt)"
pei ""
pe "vault secrets disable aws"
pe ""
rm leases.txt
clear
