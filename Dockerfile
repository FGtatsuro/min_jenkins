FROM jenkins/jenkins:2.222.4-slim
LABEL maintainer="FGtatsuro"

# Ref. https://github.com/jenkinsci/docker#preinstalling-plugins
RUN /usr/local/bin/install-plugins.sh configuration-as-code:latest
