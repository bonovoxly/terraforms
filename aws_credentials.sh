#!/usr/bin/env bash
CREDENTIAL_FILE=~/.aws/config

export AWS_ACCESS_KEY_ID=`cat $CREDENTIAL_FILE | grep -v "^#.*" | grep aws_access_key_id | awk '{ print $NF }'`
export AWS_SECRET_ACCESS_KEY=`cat $CREDENTIAL_FILE | grep -v "^#.*" | grep aws_secret_access_key | awk '{ print $NF }'`

