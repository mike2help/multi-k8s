docker build -t mike2help/multi-client:latest -t mike2help/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mike2help/multi-server:latest -t mike2help/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mike2help/multi-worker:latest -t mike2help/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mike2help/multi-client:latest
docker push mike2help/multi-server:latest
docker push mike2help/multi-worker:latest

docker push mike2help/multi-client:$SHA
docker push mike2help/multi-server:$SHA
docker push mike2help/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mike2help/multi-server:$SHA
kubectl set image deployments/client-deployment client=mike2help/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mike2help/multi-worker:$SHA

