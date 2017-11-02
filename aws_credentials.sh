#!/usr/bin/env bash
# If no variable is defined, then error
CREDENTIAL_FILE=~/.aws/config

# Get some variables with sed/awk.
# The bracketed field should be the subscription ID.
export AWS_ACCESS_KEY_ID=`cat $CREDENTIAL_FILE | grep -v "^#.*" | grep aws_access_key_id | awk '{ print $NF }'`
export AWS_SECRET_ACCESS_KEY=`cat $CREDENTIAL_FILE | grep -v "^#.*" | grep aws_secret_access_key | awk '{ print $NF }'`

