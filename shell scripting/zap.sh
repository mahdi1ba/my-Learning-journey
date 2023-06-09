#!/bin/bash
PORT=$(kubectl -n default get svc ${serviceName} -o json | jq .spec.ports[].nodePort)

# first run this 
chmod 777 $(pwd)
echo $(id -u):$(id -g)
docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-weekly zap-api-scan.py -t $applicationURL:$PORT/v3/api-docs -f openapi -r zap_report.html

exit_code=$?

# comment above cmd and uncomment below lines to run with CUSTOM RULES

#html report
sudo mkdir -p owasp-zap-report
sudo mv zap_report.html owasp-zap-report

echo "Exist Code : $exit_code"

if [[ ${exit_code} -ne 0 ]]; then
    echo "OWSP ZAP Report has either low/medium/high risk . please check the HTML report"
    exit 1;
else
    echo " OWSP ZAP did not report any risk"
fi;
