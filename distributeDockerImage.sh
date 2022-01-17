docker buildx build --platform linux/arm/v7 -t 08021986/ping-neo4j:v1 . --push
kubectl get pods -n dev --no-headers=true | awk '/ping-neo4j/{print $1}' | xargs kubectl delete pod -n dev