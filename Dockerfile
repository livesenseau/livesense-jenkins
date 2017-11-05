############################################################
# Dockerfile to build Jenkins container images
# Based on Alpine
############################################################

# Set the base image to Alpine
FROM jenkins/jenkins:2.87-alpine

############## UPDATE AND INSTALL BINARIES #################

# Change to adequate user
USER root

# Update the repository sources list
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories 

# Install Jenkins Plugins
RUN install-plugins.sh bitbucket \
    && install-plugins.sh build-pipeline-plugin \
    && install-plugins.sh build-timeout \
    && install-plugins.sh email-ext \
    && install-plugins.sh github-organization-folder \
    && install-plugins.sh gradle \
    && install-plugins.sh greenballs \
    && install-plugins.sh workflow-aggregator \
    && install-plugins.sh pipeline-aws \
    && install-plugins.sh s3 \
    && install-plugins.sh shared-workspace \
    && install-plugins.sh ssh-slaves \
    && install-plugins.sh timestamper \
    && install-plugins.sh ws-cleanup

# Execute APK commands
RUN apk update \
    && apk add --no-cache mongodb-tools=3.4.9-r0 \
    && apk add --no-cache nodejs=8.9.0-r0 \
    && apk add --no-cache nodejs-npm=8.9.0-r0

# Install NPM dependencies
RUN npm install -g gulp@3.9.1 jasmine@2.5.2 jasmine-reporters@2.2.0 swagger-tools@0.10.1

###################### CLEAN CACHES ########################

# Remove cache from package manager    
RUN npm cache clean

# Change to default user
USER jenkins