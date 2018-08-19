FROM phusion/baseimage:0.11

# This is in accordance to : https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get install -y python  python-pip python-dev build-essential  && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Fix certificate issues, found as of
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Install boto( will also install botocore) and awscli
RUN python --version && \
     pip install boto3 && \
     pip install awscli && \
     pip install athena-cli

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

CMD ["/sbin/my_init", "/bin/bash"]

COPY WQUPC.class /usr/local/dataintegration/
COPY links.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/links.sh