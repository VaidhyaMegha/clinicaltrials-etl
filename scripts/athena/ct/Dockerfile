FROM ubuntu:16.04

# Install python pip and pandas
RUN  apt-get update &&  apt-get install -y python  && \
     apt-get install -y python-pip && \
     apt-get install -y xmlstarlet

# Install boto( will also install botocore) and awscli
RUN python --version && \
     pip install boto3 && \
     pip install awscli


# Copy xslt and shell scripts
COPY xml_json.xslt /usr/local/dataintegration/
COPY xml_json.sh /usr/local/dataintegration/
COPY xml_json_test.sh /usr/local/dataintegration/

COPY AllPublicXMLs /tmp/

RUN chmod 777 /usr/local/dataintegration/xml_json.sh /tmp/AllPublicXMLs/



