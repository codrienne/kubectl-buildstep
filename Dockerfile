# Cloud Build caches gcr.io/cloud-builders/kubectl
# so it's faster.
# gcloud builds submit --tag gcr.io/joehicks-project/kubectl .
FROM gcr.io/cloud-builders/kubectl

RUN rm /builder/kubectl.bash || echo "did not remove /builder/kubectl.bash"
# Copy our own kubectl.bash that bypasses gcloud get-credentials.
COPY kubectl.bash /builder/kubectl.bash

ENTRYPOINT ["/builder/kubectl.bash"]