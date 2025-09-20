#!/bin/bash

echo Deploying application

for ARG in "$@"; do
    if [[ "$ARG" == *=* ]]; then
        eval "$ARG"
    fi
done

if [ -z "$service1_version" ]; then
    service1_version="1.0.0"
    echo "service1_version not provided, defaulting to $service1_version"
fi
if [ -z "$service2_version" ]; then
    service2_version="1.0.0"
    echo "service2_version not provided, defaulting to $service2_version"
fi

if [ -z "$service1_port" ]; then
    service1_port=30000
    echo "service1_port not provided, defaulting to $service1_port"
fi

if [ -z "$service2_port" ]; then
    service2_port=30001
    echo "service2_port not provided, defaulting to $service2_port"
fi



helm upgrade --install avl-k8s ./k8s --set service1.version=$service1_version --set service2.version=$service2_version --set service1.nodePort=$service1_port --set service2.nodePort=$service2_port
echo Application deployed successfully

kubectl port-forward svc/service1 $service1_port:80 > ./kubectl_service1.log 2>&1 &
PID1=$!
kubectl port-forward svc/service2 $service2_port:81 > ./kubectl_service2.log 2>&1 &
PID2=$!
echo "Port forwarding started with PIDs: ${PORT_FORWARD_PIDS[@]}"
read -p "Press enter to continue"
echo "Stopping port forwarding..."
kill $PID1
kill $PID2

helm uninstall avl-k8s
echo "Application undeployed successfully"
