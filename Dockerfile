FROM python:3.7.0
RUN apt-get update && apt-get install -y apt-transport-https curl gnupg2 groff
RUN pip install awscli
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN touch /etc/apt/sources.list.d/kubernetes.list 
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl
RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x ./aws-iam-authenticator
RUN cp ./aws-iam-authenticator usr/local/sbin/aws-iam-authenticator
RUN curl -sL https://run.linkerd.io/install | sh
RUN mkdir workspace
RUN mkdir ./kube
COPY ./kubeconfig.template ./kube/
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN mkdir conf
ENTRYPOINT ["/entrypoint.sh"]