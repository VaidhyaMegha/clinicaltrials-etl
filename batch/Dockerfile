### All installations started

FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $PATH:/root/.gvm/bin/
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

SHELL ["/bin/bash", "-c"]

# This is in accordance to : https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get install -y python python-setuptools python-pip python-dev build-essential  && \
    apt-get install -y xmlstarlet git wget unzip jq 
	
# Fix certificate issues, found as of
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f  
     
RUN apt-get install -y  curl \
                        git \
                        mercurial \
                        make \
                        binutils \
                        bison \
                        gcc \
                        build-essential && \
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/${GVM_VERSION}/binscripts/gvm-installer) 


SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

RUN    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer;

RUN  pip install athena-cli
RUN  npm install -g xml2json-command

RUN export JAVA_HOME
CMD ["/sbin/my_init", "/bin/bash"]


### All installations complete

### Copying source code started

# ACTRN
COPY actrn/keys.json /usr/local/dataintegration/actrn/
COPY actrn/html_json.sh /usr/local/dataintegration/actrn/
COPY actrn/Download_html.sh /usr/local/dataintegration/actrn/
COPY actrn/wrapper.sh /usr/local/dataintegration/actrn/

RUN chmod +x /usr/local/dataintegration/actrn/*.sh

