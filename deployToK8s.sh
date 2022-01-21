#!/bin/bash

kubectl get pods -n dev --no-headers=true | awk '/ping-neo4j/{print $1}' | xargs kubectl delete pod -n dev