############################################################
# Dockerfile to build Jenkins container images
# Based on Alpine
############################################################

# Set the base image to Alpine
FROM jenkins:2.7.3-alpine

############## UPDATE AND INSTALL BINARIES #################

# Change to adequate user
USER root

# Update the repository sources list
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories 

# Execute APK commands
RUN apk update && apk add --no-cache mongodb-tools=r3.2.4-r1 && apk add --no-cache nodejs=6.7.0-r0

# Install NPM dependencies
RUN npm install -g gulp@3.9.1 jasmine@2.5.2 jasmine-reporters@2.2.0 swagger-tools@0.10.1

###################### CLEAN CACHES ########################

# Remove cache from package manager    
RUN npm cache clean

# Change to default user
USER jenkins