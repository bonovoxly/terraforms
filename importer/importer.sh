#!/bin/bash
# this script imports the Terraform state AND creates the equivalent .tf configuration files.

# consider creating a hash map of filenames
# declare -A variablemap
# variablemap["EIP_TF"]="eip.tf"
# variablemap["NAT_INSTANCES_TF"]="nat.tf"
# variables
EIP_TF="eip.tf"
NAT_INSTANCES_TF='nat.tf'
INTERNET_GATEWAY_TF='internet_gateway.tf'
ROUTE53_EC2_TF='ec2.tf'
ROUTE53_RECORDS_TF='route53_records.tf'
ROUTE53_ZONES_TF='route53_zones.tf'

# Gather AWS information. we do this here so functions can access them.
# Internet gateway
echo "Describing AWS Internet gateways..."
INTERNET_GATEWAY=$(aws ec2 describe-internet-gateways)
# EIP addresses
echo "Describing AWS EIPs..."
EIP_ADDRESSES=$(aws ec2 describe-addresses | jq .)
# get AWS Route53 Zones
AWS_ZONES=$(aws route53 list-hosted-zones | jq '.[]')
# NAT instances
NAT_INSTANCES=$(aws ec2 describe-nat-gateways | jq .)


# sets the working directory
function set_working_dir() {
  if [[ $1 != "" ]]; then
    cd $1
    pwd
  else
    echo "Running in current directory."
    pwd
  fi
}

# check for Terraform
function check_terraform() {
  if which terraform > /dev/null; then
    echo "Terraform is installed."
  else
    echo "Terraform is missing.  Please install - https://www.terraform.io/downloads.html"
    exit 1
  fi
}

# initialize terraform files
function initialize_tf_files() {
  echo "Wiping TF files..."
  echo "" > $EIP_TF
  echo "" > $INTERNET_GATEWAY_TF
  echo "" > $NAT_INSTANCES_TF
  echo "" > $ROUTE53_EC2_TF
  echo "" > $ROUTE53_RECORDS_TF
  echo "" > $ROUTE53_ZONES_TF
}

function aws_internet_gateway() {
  # create arrays for the internet gateway ID and VPC ID (parallel lists)
  IG_ID=($(echo ${INTERNET_GATEWAY} | jq '.InternetGateways[].InternetGatewayId' | awk -F'"' '{ print $2 }'))
  VPC_ID=($(echo ${INTERNET_GATEWAY} | jq '.InternetGateways[].Attachments[0].VpcId' | awk -F'"' '{ print $2 }'))
  echo "Creating Internet Gateway TF file: $INTERNET_GATEWAY_TF..."
  for index in ${!IG_ID[*]}; do
    echo "Adding ${IG_ID[$index]}..."
    cat <<EOF >> $INTERNET_GATEWAY_TF
# AWS Internet Gateway
resource "aws_internet_gateway" "${IG_ID[$index]}" {
  vpc_id = "${VPC_ID[$index]}"
  tags {
EOF
    # for each tag...
    # create arrays for the tag key/value pairs
    IG_KEY=($(echo ${INTERNET_GATEWAY} | jq --arg selector "${IG_ID[$index]}" '.InternetGateways[] | select(.InternetGatewayId == $selector) | .Tags[].Key'))
    IG_VALUE=($(echo ${INTERNET_GATEWAY} | jq --arg selector "${IG_ID[$index]}" '.InternetGateways[] | select(.InternetGatewayId == $selector) | .Tags[].Value' | awk -F'"' '{ print $2 }'))
    echo "$IG_KEY"
    for indexa in ${!IG_KEY[*]}; do
      echo "Adding tags ${IG_KEY[$indexa]} = ${IG_VALUE[$indexa]}..."
      cat <<EOF >> $INTERNET_GATEWAY_TF
${IG_KEY[$indexa]} = "${IG_VALUE[$indexa]}"
EOF
    done
  # finish the internet gateway TF file
  cat <<EOF >> $INTERNET_GATEWAY_TF
  }
}
EOF
    terraform_import aws_internet_gateway.${IG_ID[$index]} ${IG_ID[$index]}
  done
}

function aws_eip() {
  EIP_ID=$(echo ${EIP_ADDRESSES} | jq '.Addresses[].AllocationId' | awk -F'"' '{ print $2 }')
  for each in $EIP_ID; do
    echo "$each"
    cat <<EOF >> $EIP_TF
# AWS Elastic IP
resource "aws_eip" "${each}" {
  vpc = true
}
EOF
  terraform_import aws_eip.${each} ${each}
  done
}

function aws_route53() {
  # get the DNS zone with a trailing '.'.
  ZONE_NAME=($(echo $AWS_ZONES | jq '.[].Name' | awk -F'"' '{ print $2 }'))
  # get the DNS zone.
  ZONE_PREFIX=($(echo $AWS_ZONES | jq '.[].Name' | awk -F'"' '{ print $2 }' | sed 's/.$//g'))
  # terraform Frienly zone name.
  ZONE_TERRAFORM=($(echo $AWS_ZONES | jq '.[].Name' | awk -F'"' '{ print $2 }' | sed 's/.$//g' | sed 's/\./-/g'))
  # Route53 zone ID.
  ZONE_ID=($(echo $AWS_ZONES | jq '.[].Id' | awk -F'"' '{ print $(NF-1)}' | awk -F'/' '{ print $NF }'))
  # Get if the zone is private.
  PRIVATEZONE=($(echo $AWS_ZONES | jq '.[].Config.PrivateZone'))
  echo "${AWS_ZONES}"
  echo "${ZONE_NAME}"
  # walk through the zones.
  for indexzone in ${!ZONE_NAME[*]}; do
    echo "Creating Terraform Route53 zone record: ${ZONE_NAME[$indexzone]}"
    if [ "${PRIVATEZONE}" == "true" ]; then
      VPC_ID=$(aws route53 get-hosted-zone --id ${ZONE_ID[$indexzone]} | jq '.VPCs[].VPCId' | awk -F'"' '{ print $2 }')
    cat <<EOF >> $ROUTE53_ZONES_TF
resource "aws_route53_zone" "${ZONE_TERRAFORM[$indexzone]}" {
  lifecycle {
    ignore_changes = ["comment"]
}
  name = "${ZONE_NAME[$indexzone]}"
  vpc_id = "${VPC_ID}"
}
EOF
    else
      cat <<EOF >> $ROUTE53_ZONES_TF
resource "aws_route53_zone" "${ZONE_TERRAFORM[$indexzone]}" {
  lifecycle {
    ignore_changes = ["comment"]
  }
  name = "${ZONE_NAME[$indexzone]}"
}
EOF
    fi
    terraform_import aws_route53_zone.${ZONE_TERRAFORM[$indexzone]} ${ZONE_ID[$indexzone]}
  done
  # now get all route53 records in each zone.
  for indexzone in ${!ZONE_NAME[*]}; do
    echo "Getting Route53 records in: ${ZONE_NAME[$indexzone]} (${ZONE_ID[$indexzone]})"
    echo "Getting resource record sets..."
    RECORD_SETS=$(aws route53 list-resource-record-sets --hosted-zone-id ${ZONE_ID[$indexzone]})
    RECORD_SETS_SIMPLE=$(echo $RECORD_SETS | jq '.ResourceRecordSets | map( select( .ResourceRecords)) | map( select( .Failover == null))')
    # this gets us a way to iterate using for.  also gets us the name.
    SIMPLE_NAME=($(echo "${RECORD_SETS_SIMPLE}" | jq '.[].Name' | awk -F'"' '{ print $2 }'))
    # convert asci to wildcard.
    WILDCARD_NAME=($(echo "${RECORD_SETS_SIMPLE}" | jq '.[].Name' | awk -F'"' '{ print $2 }' | sed 's/\\\\052/\*/g'))
    # wildcard name with no trailing '.'.
    SHORT_WILDCARD_NAME=($(echo "${RECORD_SETS_SIMPLE}" | jq '.[].Name' | awk -F'"' '{ print $2 }' | sed 's/\\\\052/\*/g' | sed 's/.$//g'))
    # terraform friendly name (removes the '.'.  safest way i could find.)
    TERRAFORM_NAME=($(echo "${RECORD_SETS_SIMPLE}" | jq '.[].Name' | awk -F'"' '{ print $2 }' | sed 's/\\\\052/STAR/g' | sed 's/\.//g'))
    # resource record type
    TYPE=($(echo "${RECORD_SETS_SIMPLE}" | jq '.[].Type' | awk -F'"' '{ print $2 }'))
    # resource record TTL
    TTL=($(echo "${RECORD_SETS_SIMPLE}" | jq '.[].TTL'))

    for indexrecord in ${!SIMPLE_NAME[*]}; do
      echo "Getting Route53 simple resource record values..."
      echo " Creating Route53 simple resource record: ${SIMPLE_NAME[$indexrecord]}"
      cat <<EOF >> $ROUTE53_RECORDS_TF
resource "aws_route53_record" "${ZONE_ID[$indexzone]}_${TERRAFORM_NAME[$indexrecord]}_${TYPE[$indexrecord]}" {
  zone_id = "${ZONE_ID[$indexzone]}"
  name = "${WILDCARD_NAME[$indexrecord]}"
  type = "${TYPE[$indexrecord]}"
  ttl = "${TTL[$indexrecord]}"
EOF
      RECORDS=$(echo ${RECORD_SETS_SIMPLE} | jq -c --arg i $indexrecord '.[$i| tonumber].ResourceRecords' | sed 's/{\"Value\"\://g' | sed 's/}//g' | sed 's/\\//g' | sed 's/\"\"/\"/g')
      echo "records: $RECORDS"
      cat <<EOF >> $ROUTE53_RECORDS_TF
  records = ${RECORDS}
}
EOF
      terraform_import aws_route53_record.${ZONE_ID[$indexzone]}_${TERRAFORM_NAME[$indexrecord]}_${TYPE[$indexrecord]} "${ZONE_ID[$indexzone]}_${SHORT_WILDCARD_NAME[$indexrecord]}_${TYPE[$indexrecord]}"
    done
  done

}

function aws_nat_gateway() {
  # Get array of values for NAT gateways.
  NAT_EIP_ALLOCATION_ID=($(echo ${NAT_INSTANCES} | jq '.NatGateways[].NatGatewayAddresses[0].AllocationId' | awk -F'"' '{ print $2 }'))
  NAT_ID=($(echo ${NAT_INSTANCES} | jq '.NatGateways[].NatGatewayId' | awk -F'"' '{ print $2 }'))
  NAT_SUBNET_ID=($(echo ${NAT_INSTANCES} | jq '.NatGateways[].SubnetId' | awk -F'"' '{ print $2 }'))
  NAT_VPC_ID=($(echo ${NAT_INSTANCES} | jq '.NatGateways[].VpcId' | awk -F'"' '{ print $2 }'))

  for index in ${!NAT_ID[*]}; do
    echo "NAT ID: ${NAT_ID[$index]}"
    N_VPC_ID=$(echo ${NAT_INSTANCES} | jq --arg n "${NAT_ID[$index]}" '.NatGateways | map( select( .NatGatewayId == $n )) | .[].VpcId' | awk -F'"' '{ print $2 }')
    IGW_ID=$(echo ${INTERNET_GATEWAY} | jq --arg nid "${N_VPC_ID}" '.InternetGateways | map( select( .Attachments[0].VpcId == $nid )) | .[].InternetGatewayId' | awk -F'"' '{ print $2 }')
    echo "NAT instance VPC ID: $N_VPC_ID"
    echo "Internet Gateway ID: $IGW_ID"
    echo "Creating NAT instances configuration and importing to Terraform: ${NAT_ID[$index]}"
    cat <<EOF >> $NAT_INSTANCES_TF
resource "aws_nat_gateway" "${NAT_ID[$index]}" {
  depends_on = [
    "aws_eip.${NAT_EIP_ALLOCATION_ID[$index]}",
    "aws_internet_gateway.${IGW_ID}"
  ]
  allocation_id = "${NAT_EIP_ALLOCATION_ID[$index]}"
  subnet_id = "${NAT_SUBNET_ID[$index]}"
}
EOF
  terraform_import aws_nat_gateway.${NAT_ID[$index]} ${NAT_ID[$index]}
  done
}

# function aws_vpc() {
#   # VPCs
#   VPCS=$(aws ec2 describe-vpcs | jq .)
#   VPC_ID=($(echo ${VPCS} | jq '.Vpcs[].VpcId'))
#   for indexvpc in ${!VPC_ID[*]}; do
#     echo "Creating VPC configuration and importing to Terraform: ${VPC_ID[$indexvpc]}"
#     cat <<EOF >> $VPC_TF
# resource "aws_vpc" "${VPC_ID[$indexvpc]}" {
#   cidr_block = "${ var.cidr}.0.0/16"
#   instance_tenancy = "${ var.tenancy }"
#   enable_dns_hostnames = "True"
#   tags {
#     Name = "${var.env }-vpc"
#     Environment = "${ var.env }"
#   }
# }
# EOF
# }

function terraform_import() {
  echo "Terraform state: ${1}"
  echo "Terraform resource ID: ${2}"
  STATE=$(terraform state list ${1})
    if [ "${STATE}" != "" ]; then
      echo "Terraform state ${1} exists. Moving on."
    else
      if echo "${1}" | grep "aws_route53_zone" ; then
        echo "Importing ${1} ${2}..."
        terraform import ${1} ${2}
        # hack to get the force_destroy correct
        echo "Hack to add force_destroy == false on the zone"
        jq --arg path "${1}" '.modules[0].resources[$path].primary.attributes.force_destroy = "false"' terraform.tfstate > terraform.tmp
        cat terraform.tmp > terraform.tfstate
        rm terraform.tmp
      else
        echo "Importing ${1} ${2}..."
        terraform import ${1} ${2}
      fi
    fi

}
# run
set_working_dir "$1"
initialize_tf_files
aws_route53
aws_internet_gateway
aws_eip
aws_nat_gateway
