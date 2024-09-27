# Use the official Jenkins LTS (Long-Term Support) image
FROM jenkins/jenkins:lts

# Switch to the root user to install additional packages
USER root

# Install additional packages, e.g., Docker inside the container, so Jenkins can run Docker containers
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    vim \
    git \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Add the Jenkins user to the Docker group
RUN usermod -aG docker jenkins

# Allow the Jenkins user to execute sudo commands without a password
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Switch back to the Jenkins user
USER jenkins

# Expose the port where Jenkins will be accessible
EXPOSE 8080

# Define the default command to start Jenkins
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]