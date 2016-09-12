#!/usr/bin/env bash
# configuring credentials for Terraform

# If no variable is defined, use the default `~/.azure/credentials`.
if [ $# -eq 0 ]; then
  CREDENTIAL_FILE=~/.azure/credentials
else
  CREDENTIAL_FILE=$1
fi

# Check if the file exists.
if [ ! -f $CREDENTIAL_FILE ] ; then
  echo "Credentials file $CREDENTIAL_FILE does not exist.  Be sure the Azures credentials file is specified (ie, ~/.azure.credentials).  Exiting."
  exit 1
fi

# Get some variables with sed/awk.
# The bracketed field should be the subscription ID.
export ARM_SUBSCRIPTION_ID=`head -n 1 $CREDENTIAL_FILE | sed 's/\[\(.*\)\]/\1/g'`
export ARM_CLIENT_ID=`grep client_id $CREDENTIAL_FILE | sed 's/.*\"\(.*\)\"/\1/g'`
export ARM_CLIENT_SECRET=`grep client_secret $CREDENTIAL_FILE | sed 's/.*\"\(.*\)\"/\1/g'`
export ARM_TENANT_ID=`grep tenant_id $CREDENTIAL_FILE | sed 's/.*\"\(.*\)\"/\1/g'`

# for each in $ARM_SUBSCRIPTION_ID $ARM_CLIENT_ID $ARM_CLIENT_SECRET $ARM_TENANT_ID; do
#   echo $each
# done
