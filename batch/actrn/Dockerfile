FROM ubuntu:16.04

# Install python pip
RUN  apt-get update &&  apt-get install -y python  && \
     apt-get install -y python-pip && \
     apt-get install -y xmlstarlet && \
     apt-get install -y wget && \
     apt-get install -y unzip && \
     apt-get install -y jq

# Install boto( will also install botocore) and awscli
RUN python --version && \
     pip install boto3 && \
     pip install lxml && \
     pip install awscli


# Copy python,json and shell scripts
COPY keys.json /usr/local/dataintegration/
COPY keys.py /usr/local/dataintegration/
COPY parse.py /usr/local/dataintegration/
COPY html_csv.sh /usr/local/dataintegration/


RUN chmod +x /usr/local/dataintegration/html_csv.sh



