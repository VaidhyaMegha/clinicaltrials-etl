FROM ubuntu:16.04

#Madhavi added below line
ENV GVM_VERSION=1.0.22

# Install python pip
RUN  apt-get update &&  apt-get install -y python  && \
     apt-get install -y python-pip && \
     apt-get install -y git && \
     apt-get install -y wget && \
     apt-get install -y jq

# Install boto( will also install botocore) and awscli
RUN python --version && \
     pip install boto3 && \
     pip install awscli



SHELL ["/bin/bash", "-c"]

RUN apt-get install -y  curl \
                        git \
                        mercurial \
                        make \
                        binutils \
                        bison \
                        gcc \
                        build-essential && \
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/${GVM_VERSION}/binscripts/gvm-installer) && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:/root/.gvm/bin/

SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

# Copy python,json and shell scripts
COPY html_json.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh



