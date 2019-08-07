FROM python:3.7.0
RUN apt-get update
RUN apt-get install -y apt-utils apt-transport-https curl gnupg2 groff nano
RUN pip install --upgrade pip
RUN pip install awscli --upgrade
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN touch /etc/apt/sources.list.d/kubernetes.list 
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl
RUN apt-get upgrade -y
RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x ./aws-iam-authenticator
RUN cp ./aws-iam-authenticator usr/local/sbin/aws-iam-authenticator
RUN curl -sL https://run.linkerd.io/install | sh
RUN curl -o helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-amd64.tar.gz
RUN tar xzf helm.tar.gz
RUN cp ./linux-amd64/helm usr/local/sbin/
RUN wget -O kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
RUN chmod +x ./kops
RUN mv ./kops /usr/local/bin/
RUN wget https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 -O heptio-authenticator-aws
RUN chmod +x heptio-authenticator-aws
RUN mv heptio-authenticator-aws /usr/local/bin/
RUN wget -O helmfile https://github.com/roboll/helmfile/releases/download/v0.41.0/helmfile_linux_amd64
RUN chmod +x helmfile
RUN mv helmfile /usr/local/bin/
RUN wget https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.11.5.linux-amd64.tar.gz
RUN rm ./go1.11.5.linux-amd64.tar.gz
RUN mkdir workspace
COPY ./kubeconfig.template.yaml ./
COPY ./*.sh ./
COPY ./export_ca_data.sh /usr/local/bin/export_ca_data
COPY ./bashrc /
RUN chmod +x /entrypoint.sh
RUN mkdir conf
RUN cat /bashrc >> ~/.bashrc
RUN rm /bashrc
RUN wget https://github.com/heptio/velero/releases/download/v1.0.0/velero-v1.0.0-linux-amd64.tar.gz
RUN tar -xzvf velero-v1.0.0-linux-amd64.tar.gz
RUN cp ./velero-v1.0.0-linux-amd64/velero usr/local/sbin
RUN curl -sSL https://get.pulumi.com | sh
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN ln -s ~/.pulumi/bin/pulumi /usr/local/bin/pulumi
WORKDIR /workspace
RUN helm init --client-only
RUN /usr/local/go/bin/go get github.com/hairyhenderson/gomplate/cmd/gomplate
RUN helm plugin install https://github.com/chartmuseum/helm-push
ENTRYPOINT ["/entrypoint.sh"]