#!/bin/bash
# this script imports the Terraform state AND creates the equivalent .tf configuration files.

# consider creating a hash map of filenames
# declare -A variablemap
# variablemap["EIP_TF"]="eip.tf"
# variablemap["NAT_INSTANCES_TF"]="nat.tf"
# variables
EC2_TF="ec2.tf"
EIP_TF="eip.tf"
IAM_ROLE_TF="iam_role.tf"
IAM_PROFILE_TF="iam_profile.tf"
IAM_ROLE_POLICY_TF="iam_role_policy.tf"
NAT_INSTANCES_TF='nat.tf'
INTERNET_GATEWAY_TF='internet_gateway.tf'
ROUTE53_EC2_TF='ec2.tf'
ROUTE53_RECORDS_TF='route53_records.tf'
ROUTE53_ZONES_TF='route53_zones.tf'
SUBNET_TF='subnet.tf'
VPC_TF='vpc.tf'

# Gather AWS information. we do this here so functions can access them.
# Internet gateway
# echo "Describing AWS Internet gateways..."
# INTERNET_GATEWAY=$(aws ec2 describe-internet-gateways)
# # EIP addresses
# echo "Describing AWS EIPs..."
# EIP_ADDRESSES=$(aws ec2 describe-addresses | jq .)
# # get AWS Route53 Zones
# echo "Describing AWS Route53 zones..."
# AWS_ZONES=$(aws route53 list-hosted-zones | jq '.[]')
# # NAT instances
# echo "Describing AWS NAT instances..."
# NAT_INSTANCES=$(aws ec2 describe-nat-gateways | jq .)
# # subnets
# echo "Describing AWS subnets..."
# SUBNETS=$(aws ec2 describe-subnets)
# # VPCs
# echo "Describing AWS VPCs..."
# VPCS=$(aws ec2 describe-vpcs)
# IAM Role
echo "Describing AWS IAM Roles..."
IAM_ROLE=$(aws iam list-roles)
# IAM Policy
echo "Describing AWS IAM Policies..."
IAM_PROFILE=$(aws iam list-instance-profiles)
echo "Describe AWS EC2 Instances..."
EC2_INSTANCES=$(aws ec2 describe-instances)


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
  echo "" > $EC2_TF
  echo "" > $EIP_TF
  echo "" > $IAM_ROLE_TF
  echo "" > $IAM_PROFILE_TF
  echo "" > $IAM_ROLE_POLICY_TF
  echo "" > $INTERNET_GATEWAY_TF
  echo "" > $NAT_INSTANCES_TF
  echo "" > $ROUTE53_EC2_TF
  echo "" > $ROUTE53_RECORDS_TF
  echo "" > $ROUTE53_ZONES_TF
  echo "" > $SUBNET_TF
  echo "" > $VPC_TF
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
    IG_KEY=($(echo ${INTERNET_GATEWAY} | jq --arg selector "${IG_ID[$index]}" '.InternetGateways[] | select(.InternetGatewayId == $selector) | .Tags[].Key' | awk -F'"' '{ print $2 }'))
    IG_VALUE=($(echo ${INTERNET_GATEWAY} | jq --arg selector "${IG_ID[$index]}" '.InternetGateways[] | select(.InternetGatewayId == $selector) | .Tags[].Value' | awk -F'"' '{ print $2 }'))
    for indexa in ${!IG_KEY[*]}; do
      echo "Adding tags ${IG_KEY[$indexa]} = ${IG_VALUE[$indexa]}..."
      cat <<EOF >> $INTERNET_GATEWAY_TF
"${IG_KEY[$indexa]}" = "${IG_VALUE[$indexa]}"
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

function aws_vpc() {
  # VPCs
  VPC_ID=($(echo ${VPCS} | jq '.Vpcs[].VpcId' | awk -F'"' '{ print $2 }'))
  VPC_CIDR=($(echo ${VPCS} | jq '.Vpcs[].CidrBlock' | awk -F'"' '{ print $2 }'))
  VPC_TENANCY=($(echo ${VPCS} | jq '.Vpcs[].InstanceTenancy' | awk -F'"' '{ print $2 }'))
  for indexvpc in ${!VPC_ID[*]}; do
    echo "Getting DNS hostname settings for ${VPC_ID[$indexvpc]}..."
    ENABLE_DNS=$(aws ec2 describe-vpc-attribute --vpc-id ${VPC_ID[$indexvpc]} --attribute enableDnsSupport | jq '.EnableDnsSupport.Value')
    echo "Creating VPC configuration and importing to Terraform: ${VPC_ID[$indexvpc]}"
    cat <<EOF >> $VPC_TF
resource "aws_vpc" "${VPC_ID[$indexvpc]}" {
  cidr_block = "${VPC_CIDR[$indexvpc]}"
  instance_tenancy = "${VPC_TENANCY[$indexvpc]}"
  enable_dns_hostnames = "${ENABLE_DNS}"
  tags {
EOF
    # create arrays for the tag key/value pairs
    VPC_KEY=($(echo ${VPCS} | jq --arg selector "${VPC_ID[$indexvpc]}" '.Vpcs[] | select(.VpcId == $selector) | .Tags[].Key' | awk -F'"' '{ print $2 }'))
    VPC_VALUE=($(echo ${VPCS} | jq --arg selector "${VPC_ID[$indexvpc]}" '.Vpcs[] | select(.VpcId == $selector) | .Tags[].Value' | awk -F'"' '{ print $2 }'))
    echo "${VPC_ID[$indexvpc]} tag keys: $VPC_KEY"
    echo "${VPC_ID[$indexvpc]} tag values: $VPC_VALUE"
    for indexvt in ${!VPC_KEY[*]}; do
      echo "Adding tags ${VPC_KEY[$indexvt]} = ${VPC_VALUE[$indexvt]}..."
      cat <<EOF >> $VPC_TF
    "${VPC_KEY[$indexvt]}" = "${VPC_VALUE[$indexvt]}"
EOF
    done
    cat <<EOF >> $VPC_TF
  }
}
EOF
    terraform_import aws_vpc.${VPC_ID[$indexvpc]} ${VPC_ID[$indexvpc]}
  done
}

function aws_subnet() {
  # Get VPCs to find all subnets in those VPCs
  VPC_ID=($(echo ${VPCS} | jq '.Vpcs[].VpcId' | awk -F'"' '{ print $2 }'))
  for indexvpc in ${!VPC_ID[*]}; do
    echo "Finding subnets for VPC: ${VPC_ID[$indexvpc]}"
    SUBNET_ID=($(echo ${SUBNETS} | jq --arg selector "${VPC_ID[$indexvpc]}" '.Subnets | map( select( .VpcId == $selector )) | .[].SubnetId' | awk -F'"' '{ print $2 }'))
    echo "Subnet ID: ${SUBNET_ID}"
    CIDR_BLOCK=($(echo ${SUBNETS} | jq --arg selector "${VPC_ID[$indexvpc]}" '.Subnets | map( select( .VpcId == $selector )) | .[].CidrBlock' | awk -F'"' '{ print $2 }'))
    AZ=($(echo ${SUBNETS} | jq --arg selector "${VPC_ID[$indexvpc]}" '.Subnets | map( select( .VpcId == $selector )) | .[].AvailabilityZone' | awk -F'"' '{ print $2 }'))
    for indexsubnet in ${!SUBNET_ID[*]}; do
      echo "Adding subnet: ${SUBNET_ID[$indexsubnet]}"
      echo "Adding cidr: ${CIDR_BLOCK[$indexsubnet]}"
      echo "Adding availability zone: ${AZ[$indexsubnet]}"
      cat <<EOF >> $SUBNET_TF
resource "aws_subnet" "${SUBNET_ID[$indexsubnet]}" {
  vpc_id = "${VPC_ID[$indexvpc]}"
  cidr_block = "${CIDR_BLOCK[$indexsubnet]}"
  availability_zone = "${AZ[$indexsubnet]}"
  tags {
EOF
      # for each tag...
      # create arrays for the tag key/value pairs
      SUBNET_KEY=($(echo ${SUBNETS} | jq --arg selector "${SUBNET_ID[$indexsubnet]}" '.Subnets | map( select( .SubnetId == $selector )) | .[].Tags[].Key' | awk -F'"' '{ print $2 }'))
      SUBNET_VALUE=($(echo ${SUBNETS} | jq --arg selector "${SUBNET_ID[$indexsubnet]}" '.Subnets | map( select( .SubnetId == $selector )) | .[].Tags[].Value' | awk -F'"' '{ print $2 }'))
      echo "key: ${SUBNET_KEY}"
      echo "value: ${SUBNET_VALUE}"
      for indexst in ${!SUBNET_KEY[*]}; do
        echo "Adding tags ${SUBNET_KEY[$indexst]} = ${SUBNET_VALUE[$indexst]}..."
        cat <<EOF >> $SUBNET_TF
    "${SUBNET_KEY[$indexst]}" = "${SUBNET_VALUE[$indexst]}"
EOF
      done
      cat <<EOF >> $SUBNET_TF
  }
}
EOF
      terraform_import aws_subnet.${SUBNET_ID[$indexsubnet]} ${SUBNET_ID[$indexsubnet]}
    done
  done
}

function aws_iam_role() {
  # Get IAM role
  ROLE_NAME=($(echo ${IAM_ROLE} | jq '.Roles[].RoleName' | awk -F'"' '{ print $2 }'))
  IAM_PATH=($(echo ${IAM_ROLE} | jq '.Roles[].Path' | awk -F'"' '{ print $2 }'))
  for indexrole in ${!ROLE_NAME[*]}; do
    DOCUMENT=$(echo ${IAM_ROLE} | jq --arg i $indexrole '.Roles[$i|  tonumber].AssumeRolePolicyDocument')
    echo "Creating role: ${ROLE_NAME[$indexrole]}"
    cat <<EOL >> $IAM_ROLE_TF
resource "aws_iam_role" "${ROLE_NAME[$indexrole]}" {
  name = "${ROLE_NAME[$indexrole]}"
  path = "${IAM_PATH[$indexrole]}"
  assume_role_policy = <<EOF
${DOCUMENT}
EOF
}
EOL
    # get IAM attached role policy
    aws_iam_policy ${ROLE_NAME[$indexrole]}
    terraform_import aws_iam_role.${ROLE_NAME[$indexrole]} ${ROLE_NAME[$indexrole]}
  done
}

function aws_iam_profile() {
  # Get policies
  PROFILE_NAME=($(echo ${IAM_PROFILE} | jq '.InstanceProfiles[].InstanceProfileName' | awk -F'"' '{ print $2 }'))
  PROFILE_ROLE_NAME=($(echo ${IAM_PROFILE} | jq '.InstanceProfiles[].Roles[].RoleName' | awk -F'"' '{ print $2 }'))
  for indexprofile in ${!PROFILE_NAME[*]}; do
    echo "Creating policy: ${PROFILE_NAME[$indexprofile]}"
    cat <<EOF >> $IAM_PROFILE_TF
resource "aws_iam_instance_profile" "${PROFILE_NAME[$indexprofile]}" {
  name = "${PROFILE_NAME[$indexprofile]}"
  roles = ["${PROFILE_ROLE_NAME[$indexprofile]}"]
}
EOF
    terraform_import aws_iam_instance_profile.${PROFILE_NAME[$indexprofile]} ${PROFILE_NAME[$indexprofile]}
  done
}

# untested as of 2017-04-05
# function aws_iam_role_policy() {
#   # Get roles
#   ROLE_NAME=($(echo ${IAM_ROLE} | jq '.Roles[].RoleName' | awk -F'"' '{ print $2 }'))
#   for indexrole in ${!ROLE_NAME[*]}; do
#     ROLE_POLICY=$(aws iam list-role-policies --role-name ${ROLE_NAME[$indexrole]})
#     POLICY_NAME=($(echo ${ROLE_POLICY} | jq '.PolicyNames[]' | awk -F'"' '{ print $2 }'))
#     for indexpolicy in ${!POLICY_NAME[*]}; do
#       POLICY_DOCUMENT=$(aws iam get-role-policy --role-name ${ROLE_NAME[$indexrole]} --policy-name ${POLICY_NAME[$indexpolicy]} | jq '.PolicyDocument')
#     cat <<EOL >> $IAM_ROLE_POLICY_TF
# resource "aws_iam_role_policy" "${POLICY_NAME[$indexpolicy]}" {
#   name = "${POLICY_NAME[$indexpolicy]}"
#   role = "${ROLE_NAME[$indexrole]}"
#   policy = <<EOF
# ${POLICY_DOCUMENT}
# EOF
# }
# EOL
#       terraform_import aws_iam_role_policy.${ROLE_NAME[$indexrole]}-${POLICY_NAME[$indexpolicy]} ${ROLE_NAME[$indexrole]}:${POLICY_NAME[$indexpolicy]}
#     done
#   done
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

function aws_ec2() {
  INSTANCE_ID=($(echo ${EC2_INSTANCES} | jq '.Reservations[].Instances[].InstanceId'))
  INSTANCE_AMI=($(echo ${EC2_INSTANCES} | jq '.Reservations[].Instances[].ImageId'))
  INSTANCE_PUBLICDNS($(echo ${EC2_INSTANCES} | jq . '.Reservations[].Instances[].PublicDnsName'))
  INSTANCE_TYPE=($(echo ${EC2_INSTANCES} | jq '.Reservations[].Instances[].InstanceType'))
  IAM_PROFILE=($(echo ${EC2_INSTANCES} | jq '.Reservations[].Instances[].IamInstanceProfile.Arn' | awk -F'/' '{ print $NF }' | awk -F'"' '{ print $1 }'))
  KEY_NAME=($(echo ${EC2_INSTANCES} | jq '.Reservations[].Instances[].KeyName'))
  PRIVATE_IP=($(echo ${EC2_INSTANCES} | jq '.Reservations[].Instances[].PrivateIpAddress'))
  SUBNET_ID=($(echo ${EC2_INSTANCES} | jq '.Reservations[].Instances[].SubnetId'))
  TENANCY=($(echo ${EC2_INSTANCES} | jq '.Reservations[].Instances[].Placement.Tenancy'))
  for indexec2 in ${!INSTANCE_ID[*]}; do
    echo "Adding instance ID: ${EC2_INSTANCES[$indexec2]}"
    cat <<EOF >> $EC2_TF
    ami = "${INSTANCE_AMI[$indexec2]}"
    #associate_public_ip_address = if the instance
    iam_instance_profile = "${IAM_PROFILE[$indexec2]}"
    instance_type = "t2.micro"
    lifecycle {
      ignore_changes = ["ami"]
    }
    root_block_device {
      volume_type = "gp2"
      volume_size = "20"
    }
    key_name = "${ var.keypair }"
    private_ip = "${ var.cidr }.0.4"
    subnet_id = "${ aws_subnet.opspublic-c.id }"
    tenancy = "${ var.tenancy }"
    vpc_security_group_ids = ["${ aws_security_group.openvpn.id }"]
EOF
    SECURITY_GROUPS=$(echo ${EC2_INSTANCES} | jq --arg e ${} '.Reservations[].Instances[] | select( .InstanceId == $e) |  .SecurityGroups[].GroupId' | awk -F'"' '{ print $1 }')

}

# run
set_working_dir "$1"
initialize_tf_files
# aws_vpc
# aws_subnet
# aws_internet_gateway
# aws_eip
# aws_nat_gateway
# aws_iam_role
# aws_iam_profile
# aws_iam_role_policy
aws_ec2
# aws_route53
