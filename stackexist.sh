#!/bin/bash
sname=BaseInfra
if (aws cloudformation wait stack-exists --stack-name $sname --region ${region})
then
    echo "Updating the existing stack"
    aws cloudformation update-stack --stack-name $sname --template-body file:///home/ec2-user/workspace/BaseInfraWM/Base-Infra/CSD-PARENT.yml --parameters file:///home/ec2-user/workspace/BaseInfraWM/Base-Infra/input-${DEPLOY_ENV}.json --capabilities CAPABILITY_NAMED_IAM --region ${REGION} --notification-arns arn:aws:sns:us-east-2:108970575545:CloudformationStatus
else
    echo " Creating a new stack "
    aws cloudformation create-stack --stack-name $sname --template-body file:///home/ec2-user/workspace/BaseInfraWM/Base-Infra/CSD-PARENT.yml --parameters file:///home/ec2-user/workspace/BaseInfraWM/Base-Infra/input-${DEPLOY_ENV}.json --capabilities CAPABILITY_NAMED_IAM --region ${REGION} --notification-arns arn:aws:sns:us-east-2:108970575545:CloudformationStatus
fi
