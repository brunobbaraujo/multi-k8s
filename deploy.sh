docker build -t brunobento/multi-client:latest -t brunobento/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brunobento/multi-server:latest -t brunobento/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brunobento/multi-worker:latest -t brunobento/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brunobento/multi-client:latest
docker push brunobento/multi-server:latest
docker push brunobento/multi-worker:latest

docker push brunobento/multi-client:$SHA
docker push brunobento/multi-server:$SHA
docker push brunobento/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brunobento/multi-server:$SHA
kubectl set image deployments/client-deployment client=brunobento/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brunobento/multi-worker:$SHA