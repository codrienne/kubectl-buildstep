# Cloud Build caches gcr.io/cloud-builders/kubectl
# so it's faster.
# gcloud builds submit --tag gcr.io/joehicks-project/kubectl .
FROM gcr.io/cloud-builders/kubectl

# Copy our own kubectl.bash that bypasses gcloud get-credentials.
COPY kubectl.bash /builder/kubectl.bash

ENTRYPOINT ["/builder/kubectl.bash"]