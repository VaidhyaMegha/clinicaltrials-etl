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
     pip install awscli


# Copy xslt and shell scripts
COPY xml_json.xslt /usr/local/dataintegration/
COPY xml_json.sh /usr/local/dataintegration/
COPY xml_json_test.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/


RUN chmod +x /usr/local/dataintegration/wrapper.sh

RUN chmod +x /usr/local/dataintegration/xml_json.sh
RUN chmod +x /usr/local/dataintegration/xml_json_test.sh


CMD bash "/usr/local/dataintegration/wrapper.sh"  "AllPublicXMLs" "yes"
