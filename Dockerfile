FROM jenkins/inbound-agent:4.11-1-jdk11
USER root

LABEL maintainer="Juergen wewer"


# install some basic command line tools
RUN apt-get update; \
	  apt-get install -y curl wget vim tar bash git

RUN apt-get install python3-pip -y
RUN pip3 install ansible
RUN ansible-galaxy collection install community.kubernetes

RUN curl https://baltocdn.com/helm/signing.asc | apt-key add -
RUN apt-get install apt-transport-https --yes
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN apt-get update
RUN apt-get install helm

#RUN mkdir /.git && \
#    chmod 777 /.git

#    mkdir ${HOME}/.kube && \
#RUN microdnf update && \
#    microdnf install git tar && \
#    curl -LO -O https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 && \
#    chmod +x ./jq-linux64  && \
#    mv jq-linux64 /usr/local/bin/jq  && \
#    curl -LO -O https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux && \
#    chmod +x ./sops-${SOPS_VERSION}.linux  && \
#    mv ./sops-${SOPS_VERSION}.linux /usr/local/bin/sops  && \
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.21.9/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

RUN curl -sSLf https://github.com/moby/buildkit/releases/download/v0.10.0/buildkit-v0.10.0.linux-amd64.tar.gz | tar -xz -C /usr/local/bin/ --strip-components=1
RUN buildkitd

#    curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz | tar zxv -C /var/tmp && \
#    chmod +x /var/tmp/kustomize && \
#    mv /var/tmp/kustomize /usr/local/bin/kustomize && \
#    curl -L https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz | tar zxv -C /var/tmp  && \
#    mv /var/tmp/kubeval /usr/local/bin/kubeval && \
#    curl -L https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_amd64.tar.gz | tar zxv -C /var/tmp  && \
#    mv /var/tmp/gh_${GH_CLI_VERSION}_linux_amd64/bin/gh /usr/local/bin/gh && rm -rf /var/tmp/gh_${GH_CLI_VERSION}_linux_amd64 && \
#    curl -L https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz | tar zxv -C /var/tmp && \
#    mv /var/tmp/hub-linux-amd64-${HUB_VERSION}/bin/hub /usr/local/bin/hub && rm -rf /var/tmp/hub-linux-amd64-${HUB_VERSION} && \
#    microdnf clean all

#COPY library deployer validation-service/validation /opt/app-root/
#COPY library deployer /opt/app-root/

# allow caching for kubectl in .kube dir
#RUN chmod a+rwx ${HOME} && \
#    mkdir ${HOME}/.kube && \
#    chmod a+rw ${HOME}/.kube && \
#    mkdir ${HOME}/.gnupg && \
#    chmod a+rw ${HOME}/.gnupg

#USER 1001

ENTRYPOINT [ "/bin/bash" ]
#CMD [ "/opt/app-root/deployer" ]