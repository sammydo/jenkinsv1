FROM jenkins/jenkins:lts-alpine

USER root

# Skip the Jenkins setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Seutup admin user from docker secrets
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

# USER root

# Install the latest Docker CE binaries
RUN apk update && apk add \
      ca-certificates \
      curl \
      gnupg

# RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
#     apk -U add docker py-pip

# RUN pip install docker-compose

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
