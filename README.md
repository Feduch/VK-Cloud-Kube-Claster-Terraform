# VK Cloud

Описание инфраструктуры на terraform

Создается кластер Kubernetes

# Получить cluster_kubeconfig
export KUBECONFIG=~/.kube/ai-issue-genius-cluster_kubeconfig.yaml 

# Добавить секреты для доступа к образам на GitLab
kubectl create secret docker-registry gitlab-registry \
  --docker-server=registry.gitlab.com \
  --docker-username=username \
  --docker-password=glpat-*** \
  --docker-email=email \
  -n ai-issue-genius

# Настроить редирект на API
kubectl apply -f redirect-ingress.yaml

# Dashboard
kauthproxy -n kubernetes-dashboard https://kubernetes-dashboard.svc

# prometheus
## Запуск
kubectl -n prometheus-monitoring port-forward service/kube-prometheus-stack-grafana 8001:80
## Получить пароль к дашборку
kubectl -n prometheus-monitoring get secret kube-prometheus-stack-grafana -o jsonpath='{.data.admin-password}' | base64 --decode

# Прочее
kubectl config set-context --current --namespace=ai-issue-genius
kubectl describe pod postgres-54dfd9b479-t2cnd -n ai-issue-genius


