# microk8s-snippets

microk8s snippets

## Configuration file

```sh
mkdir -p ~/.kube
microk8s config > ~/.kube/config
export KUBECONFIG=~/.kube/config
```
