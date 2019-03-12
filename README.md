# kubectl-buildstep
This kubectl image is built on top of the [Cloud Build](https://cloud.google.com/cloud-build/)'s official gcr.io/cloud-builders/kubectl image.
The only difference is that the entrypoint bash script does not try to get context from env variables and does not run `gcloud container clusters get-credentials`.
This allows the user to pass in a kubeconfig as credentials without setting the context.

## Cloud Build Usage 

###  Build and push the image to your GCP project

```
# 1. Clone the repo.
git@github.com:codrienne/kubectl-buildstep.git

# 2. Build the image and push to your GCP project.
gcloud builds submit --tag gcr.io/[PROJECT_ID]/kubectl .
```

### Use the image as a buildstep

Create a cloudbuild.yaml file with your desired `kubectl` commands.
```
# cloudbuild.yaml
steps:
- name: 'gcr.io/[PROJECT_ID]/kubectl'
  entrypoint: 'bash'
  args: ['-c', 'kubectl --kubeconfig [KUBECONFIG_FILE] apply -f [FILENAME']
- name: 'gcr.io/[PROJECT_ID]/kubectl'
  entrypoint: 'bash'
  args: ['-c', 'kubectl --kubeconfig [KUBECONFIG_FILE] get pods --all-namespaces']
```

With the kubeconfig in your build source, call:

```
gcloud builds submit --config=cloudbuild.yaml [PATH_TO_SOURCE]
```

