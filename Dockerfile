FROM jenkins/jenkins:lts

# Install sudo and Terraform
USER root
RUN apt-get update && \
    apt-get install -y sudo gnupg software-properties-common curl && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | tee /etc/apt/trusted.gpg.d/hashicorp.asc && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install terraform && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch back to Jenkins user
USER jenkins
