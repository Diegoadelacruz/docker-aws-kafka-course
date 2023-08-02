FROM ubuntu:22.10

## UTILITARIOS
ENV DEBIAN_FRONTEND noninteractive
ENV KUBECTL_VERSION 1.24.13-00

# PYTHON 3
RUN apt update && \
    apt install -y --no-install-recommends software-properties-common gcc python3 python3-distutils gnupg iproute2 \
    python3-pip python3-apt python-is-python3 curl git zip unzip jq awscli maven openjdk-17-jdk htop ssh dnsutils iputils-ping vim
    
# KUBECTL
    # curl -s https://packages.cloud.google.com/apt/dists/kubernetes-xenial/main/binary-amd64/Packages | grep Version | awk '{print $2}'
    # curl -s https://packages.cloud.google.com/apt/dists/kubernetes-xenial/main/binary-arm64/Packages | grep Version | awk '{print $2}'
# RUN apt install apt-transport-https ca-certificates -y && \
    # curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \ # with issue
# RUN curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg && \
#     echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
#     apt-get update && apt-get install kubectl=$KUBECTL_VERSION -y

# HELM 3
# RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
#     chmod 700 get_helm.sh && \
#     ./get_helm.sh

# NVM (node version manager)
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
    . ~/.bashrc && \
    nvm install 18 && \
    nvm use 18 && \
    nvm alias default 18

## TERRAFORM (TFEnv)
# RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
#     echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile && \
#     . ~/.bash_profile && \
#     ln -s ~/.tfenv/bin/* /usr/local/bin && \
#     tfenv --version && \
#     tfenv install 1.3.0 && \
#     tfenv use 1.3.0

# Install Docker CE CLI
RUN apt-get update \
    && apt-get install -y lsb-release \
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce-cli

# Install Docker Compose
RUN LATEST_COMPOSE_VERSION=$(curl -sSL "https://api.github.com/repos/docker/compose/releases/latest" | grep -o -P '(?<="tag_name": ").+(?=")') \
    && curl -sSL "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

RUN curl -L -o /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/latest/download/aws-vault-linux-$(dpkg --print-architecture) && \ 
    chmod 755 /usr/local/bin/aws-vault && \
    apt install -y gnome-keyring
    
RUN mkdir -p $HOME/.aws-iam-authenticator/bin && \
    curl -Lo $HOME/.aws-iam-authenticator/bin/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_$(dpkg --print-architecture) && \
    chmod +x $HOME/.aws-iam-authenticator/bin/aws-iam-authenticator && \
    ln -s $HOME/.aws-iam-authenticator/bin/* /usr/local/bin && \
    echo 'export PATH="$HOME/.aws-iam-authenticator/bin:$PATH"' >> ~/.bash_profile

# K3D
# RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# ROOT USERS
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && echo "$SNIPPET" >> "/root/.bashrc"

ENV TZ=America/Lima
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV PATH "$HOME/.tfenv/bin:$HOME/bin:$PATH"
ENV AWS_VAULT_BACKEND "file"
RUN echo 'export AWS_VAULT_FILE_PASSPHRASE="$(cat ~/.aws/password-aws-vault)"' >> ~/.bash_profile

#RUN aws --version && \
#    kubectl version --client && \
#    helm version --client && \
#    python --version && \
#    terraform --version && \
#    aws-vault --version

RUN aws --version && \
   kubectl version --client && \
   python --version && \
   aws-vault --version

RUN apt-get clean && rm -rf /tmp/* /var/tmp/*