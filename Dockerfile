FROM python:3.7.0
RUN apt-get update && apt-get install -y apt-transport-https curl gnupg2 groff
RUN pip install --upgrade awscli
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN touch /etc/apt/sources.list.d/kubernetes.list 
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl
RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x ./aws-iam-authenticator
RUN cp ./aws-iam-authenticator usr/local/sbin/aws-iam-authenticator
RUN curl -sL https://run.linkerd.io/install | sh
RUN curl -o helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz
RUN tar xzf helm.tar.gz
RUN cp ./linux-amd64/helm usr/local/sbin/
RUN mkdir workspace
COPY ./*.sh ./
RUN chmod +x /entrypoint.sh
RUN mkdir conf
WORKDIR /workspace
ENTRYPOINT ["/entrypoint.sh"]