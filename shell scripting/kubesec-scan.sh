#!/bin/bash
#kubesec-scan.sh

#using kubesec v2 api

scan_result=$(curl -sSX POST --data-binary @"k8s_deployment_service.yaml" https://v2.kubesec.io/scan)
scan_message=$(curl -sSX POST --data-binary @"k8s_deployment_service.yaml" https://v2.kubesec.io/scan | jq .[0].message -r)
scan_score=$(curl -sSX POST --data-binary @"k8s_deployment_service.yaml" https://v2.kubesec.io/scan | jq .[0].score )


# using kubesec docker image for scanning 
# scan_result =$(docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin < k8s_deployment_service.yaml | jq .[0].message -r)
# scan_message=$(docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin <  k8s_deployment_service.yaml | jq .[0].score)
# scan_score=$(docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin <  k8s_deployment_service.yaml | jq .[0].score )

# kubesec scan result processing
#echo "Scan Score : $scan_score"

if [[ "${scan_score}" -ge 5 ]]; then
    echo "Score is $scan_score"
    echo "kubectl Scan $scan_message"
else
    echo "Score is $scan_score, which is less tahn or equal to 5."
    echo "Scanning kubernetes Resource has failed"
    exit 1;
fi;