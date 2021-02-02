#!/bin/bash
StackName=$1
Region=$2

aws cloudformation create-stack --stack-name ${StackName} --template-body file://test.yml --parameters file://input.json --region ${Region} --capabilities CAPABILITY_NAMED_IAM 
aws cloudformation wait stack-create-complete --stack-name ${StackName} --region ${Region}
EXIT_STATUS=$?

if [ "$EXIT_STATUS" -ne "0" ]
then
  echo "Stack Already Exists"
  echo "Updating the existing stack"
  aws cloudformation update-stack --stack-name ${StackName} --template-body file://test.yml --parameters file://input.json --region ${Region} --capabilities CAPABILITY_NAMED_IAM
  aws cloudformation wait stack-update-complete --stack-name ${StackName} --region ${Region}
fi