FROM ubuntu:16.04

RUN  apt-get update &&  apt-get install -y python  && \
     apt-get install -y python-pip

RUN  pip install awscli

COPY global_registry.sql /usr/local/global/
COPY utdm_automation.sh /usr/local/global/

RUN chmod +x /usr/local/global/utdm_automation.sh

