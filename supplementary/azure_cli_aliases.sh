#!/bin/bash

# Azure Resource Groups:
alias agl="az group list | jq '.[]|{name,id,location}'"

# Azure Subscriptions:
alias asl="az account list | jq '.[]|{name,id}'"

