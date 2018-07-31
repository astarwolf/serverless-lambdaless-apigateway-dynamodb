#!/usr/bin/env bash
# Copyright (c) 2017-2018 Starwolf Ltd and Richard Freeman. All Rights Reserved.
# Licensed under the Apache License, Version 2.0

#Variables
. ./common-variables.sh

#Create the roles needed by API Gateway
./create-role.sh

#Deploy your Serverless Stack using SAM + Cloudformation
aws cloudformation deploy --template-file $template.yaml --stack-name $template --capabilities CAPABILITY_IAM --region $region --profile $profile
