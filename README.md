[![CircleCI](https://circleci.com/gh/mtharpe/vault-aws-demo/tree/main.svg?style=svg)](https://circleci.com/gh/mtharpe/vault-aws-demo/tree/main)

[![Build](https://github.com/mtharpe/vault-aws-demo/actions/workflows/build.yml/badge.svg)](https://github.com/mtharpe/vault-aws-demo/actions/workflows/build.yml)

# AWS + Vault Demo Script

## Description
This is a scripted demo using Vault and AWS resources for demo purposes. The demo will show using Vault with AWS auth method and secrets engine, and will require no typing as the script does it all for you provided you read and applu the requirements section of this document.

### Requirements
+ Vault installed locally (can be container or binary, but MUST listen on 8200 and be http only)
+ AWS Account with a user called `vault_demo`
+ direnv (provides automatic setup of all environment variables)
+ Google Chrome (this is only working on Linux and Mac....)
+ The ability to follow the prompts, speak to the tech, and press "enter"

#### How to use this
First, I use tmux to allow multiple "virtal" tabs. This will enable me to start Vault on the first tab, and then create a new tab to work out of for the demo. The entire script is using demo magic, so I will split the screen with a terminal window and web UI for Vault so that I can then show off what the commands are doing and it makes for a better demo.

+ Make sure that your .envrc file is sources prior to the demo so that you have the proper exports in place
+ Ensure you have the aws-cli configured
+ Start Vault (via container or local binary)
+ Run `./1-vault-aws-auth-method.sh && 2-vault-aws-dynamic-secrets-demo.sh`
+ Move through the demo pressing only the `enter` or `return` key
+ Talk to each command, but dont wait too long because there are timeouts in Vault that will cause issues if you do