FROM jenkins/jenkins:lts

# Change to adequate user
USER root

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

RUN apt-get update && \
		apt-get install -y build-essential

# Execute APK commands
#RUN apk update \
#    && apk add --no-cache mongodb-tools=4.0.5-r0 \
#    && apk add --no-cache nodejs=10.16.3-r0 \
#    && apk add --no-cache nodejs-npm=10.16.3-r0

# Install NPM dependencies
#RUN npm install -g gulp@3.9.1 jasmine@2.5.2 jasmine-reporters@2.2.0 swagger-tools@0.10.1

###################### CLEAN CACHES ########################

# Remove cache from package manager
#RUN npm cache clean --force

# Change to default user
USER jenkins
