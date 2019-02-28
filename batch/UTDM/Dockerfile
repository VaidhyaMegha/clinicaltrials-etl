FROM ubuntu:16.04

RUN  apt-get update &&  apt-get install -y python  && \
     apt-get install -y python-pip && \
     apt-get install -y jq

# Install boto( will also install botocore) and awscli
RUN python --version && \
     pip install boto3 && \
     pip install awscli

COPY global_registry.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/global_registry.sh

