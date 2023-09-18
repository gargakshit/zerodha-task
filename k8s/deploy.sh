#!/usr/bin/env sh

NAMESPACE="demo-ops"

ensure_namespace() {
  echo "Ensuring namespace $NAMESPACE"
  # Not just doing kubectl create namespace $NAMESPACE as it
  # may already exist and the script may error.
  kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
}

install_redis() {
  echo "Installing redis"
  helm upgrade --install -n $NAMESPACE redis oci://registry-1.docker.io/bitnamicharts/redis -f redis/values.yaml
}

install_app() {
  echo "Installing the app"
  helm upgrade --install -n $NAMESPACE app ./app -f app/values.yaml
}

ensure_namespace
install_redis
install_app
