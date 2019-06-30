# Update versions as needed.
FROM lachlanevenson/k8s-helm:v2.14.1
FROM lachlanevenson/k8s-kubectl:v1.15.0

# We build our own base awscli alpine image becase there is not yet an official
# aws/aws-cli Alpine Docker image or stable Alpine package.
# Ref: https://github.com/aws/aws-cli/pull/4062
# Ref: https://pkgs.alpinelinux.org/package/edge/testing/x86/aws-cli
FROM alpine:3.10
ENV AWSCLI_VERSION 1.16.190
RUN apk add -U --no-cache python3 ca-certificates \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 --no-cache-dir install awscli==${AWSCLI_VERSION}
COPY --from=0 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=1 /usr/local/bin/kubectl /usr/local/bin/kubectl
