#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -n "  - Checking terraform fmt.. "
TERRAFORM_FMT_RESULT=$(terraform fmt -recursive)
#find a way to include `terragrunt hclfmt`

if [[ -z $TERRAFORM_FMT_RESULT ]];
then
   echo -e "${GREEN}[OK]${NC}"
else
   echo -e "${RED}Terraform fmt applied changes to file(s):"
   echo -e ${TERRAFORM_FMT_RESULT}
   echo -e "Check and commit again${NC}"
fi

echo -n "  - Checking terragrunt hclfmt.. "
TERRAGRUNT_FMT_RESULT=$(terragrunt hclfmt 2>&1 > /dev/null | awk '{print $3}')

if [[ -z $TERRAGRUNT_FMT_RESULT ]];
then
   echo -e "${GREEN}[OK]${NC}"
else
   echo -e "${RED}Terragrunt hcl fmt applied changes to file(s):"
   echo -e ${TERRAGRUNT_FMT_RESULT//msg=/}
   echo -e "Check and commit again${NC}"
fi

if [[ -z $TERRAFORM_FMT_RESULT && -z $TERRAGRUNT_FMT_RESULT ]];
then
   echo -e "${GREEN}TF and HCL files formatting check validated!${NC}"
   echo
   exit 0
else
   echo
   exit 1
fi