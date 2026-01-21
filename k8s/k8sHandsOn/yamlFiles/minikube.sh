minikube start \
    --addons="dashboard" \
    --addons="metrics-server" \
    --addons="ingress" \
    --addons="ingress-dns" \
    --feature-gates=EphemeralContainers=true
