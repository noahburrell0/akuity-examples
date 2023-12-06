## One-Liners
curl https://raw.githubusercontent.com/noahburrell0/akuity-examples/main/demos/workflows-infrastructure/k3d.sh > k3d.sh && curl https://raw.githubusercontent.com/noahburrell0/akuity-examples/main/demos/workflows-infrastructure/app-of-apps.yaml > app-of-apps.yaml && chmod +x k3d.sh && ./k3d.sh akuity INSTANCE_NAME demo1

kubectl create ns external-secrets && gcloud secrets versions access latest --secret=gcpsm-secret | kubectl create secret generic gcpsm-secret -n external-secrets --from-file=secret-access-credentials=/dev/stdin

## Links
[Workflows UI](https://localhost:30000)

[Working App UI](http://localhost:30001)

[Erroring App UI](http://localhost:30002)
