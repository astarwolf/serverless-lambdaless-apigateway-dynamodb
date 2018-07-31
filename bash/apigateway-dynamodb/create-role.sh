#!/bin/sh
# Copyright (c) 2017-2018 Starwolf Ltd and Richard Freeman. All Rights Reserved.
# Licensed under the Apache License, Version 2.0

#This Script creates an API Gateway role and attaches the 2 required policies

#Settings
. ./common-variables.sh

#Setup API Gateway Role
role_name=api-gateway-dynamo-full-user-comments
aws iam create-role --role-name ${role_name} \
    --assume-role-policy-document file://../../IAM/assume-role-api-gateway.json --profile $profile

#Add Policy for API Gateway to write to logs
role_policy_arn="arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
aws iam attach-role-policy \
    --role-name "${role_name}" \
    --policy-arn "${role_policy_arn}"  --profile ${profile}

#Create DynamoDB Policy
policy_name="dynamo-full-user-comments-api-sam"
aws iam create-policy --policy-name ${policy_name} --policy-document file://../../IAM/${policy_name}.json --profile ${profile}

#Attach Policy for API Gateway to access DynamoDB
role_policy_arn="arn:aws:iam::${aws_account_id}:policy/${policy_name}"
aws iam attach-role-policy \
    --role-name "${role_name}" \
    --policy-arn "${role_policy_arn}"  --profile ${profile}
