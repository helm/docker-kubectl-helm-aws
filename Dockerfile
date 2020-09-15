# Update versions as needed.
FROM lachlanevenson/k8s-helm:v3.3.1
FROM lachlanevenson/k8s-kubectl:v1.19.0

# We build our own base awscli alpine image becase there is not yet an official
# aws/aws-cli Alpine Docker image or stable Alpine package.
# Ref: https://github.com/aws/aws-cli/pull/4062
# Ref: https://pkgs.alpinelinux.org/package/edge/community/x86/aws-cli
FROM alpine:3.12
ENV AWSCLI_VERSION 1.18.138
RUN apk add -U --no-cache py3-pip ca-certificates \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 --no-cache-dir install awscli==${AWSCLI_VERSION}
COPY --from=0 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=1 /usr/local/bin/kubectl /usr/local/bin/kubectl
