#!/bin/bash

#k8s-deployment.sh

sed -i "s#replace#${imageName}#g" k8s_deployment_service.yaml
kubectl -n prod get deployment ${deploymentName} > /dev/null

if [[ $ ? -ne 0 ]]; then
    echo "deployment ${deploymentName} doesnt exist"
    kubectl -n prod apply -f k8s_deployment_service.yaml
else
    echo "deployment ${deploymentName} exist"
    echo "image name - ${imageName}"
    kubectl -n prod set image deploy ${deploymentName} ${containerName}=${imageName} --record=true