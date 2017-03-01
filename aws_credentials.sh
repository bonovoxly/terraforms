#!/usr/bin/env bash
# configuring credentials for Terraform
# only useful if you save your credentials in `~/.aws/config`

# If no variable is defined, use the default `~/.aws/config`.
if [ $# -eq 0 ]; then
  CREDENTIAL_FILE=~/.aws/config
else
  CREDENTIAL_FILE=$1
fi

# Check if the file exists.
if [ ! -f $CREDENTIAL_FILE ] ; then
  echo "Credentials file $CREDENTIAL_FILE does not exist.  Be sure the AWS credentials file is specified (ie, ~/.aws/config).  Exiting."
  exit 1
fi

export AWS_ACCESS_KEY_ID=`grep aws_access_key_id $CREDENTIAL_FILE | awk '{ print $NF }'`
export AWS_SECRET_ACCESS_KEY=`grep aws_secret_access_key $CREDENTIAL_FILE | awk '{ print $NF }'`
