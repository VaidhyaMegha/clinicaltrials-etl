
FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

ENV GVM_VERSION=1.0.22

ENV PATH $PATH:/root/.gvm/bin/


SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

RUN export JAVA_HOME


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


CMD ["/sbin/my_init", "/bin/bash"]

COPY GraphProcessor-1.0-SNAPSHOT.jar /usr/local/dataintegration/
COPY links.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/bin/athena
RUN chmod +x /usr/local/dataintegration/links.sh
FROM ubuntu:16.04

RUN  apt-get update &&  apt-get install -y python  && \
     apt-get install -y python-pip && \
     apt-get install -y jq

# Install boto( will also install botocore) and awscli
RUN python --version && \
     pip install boto3 && \
     pip install awscli

COPY global_registry.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/global_registry.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

COPY html_json.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/wrapper.sh
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh


# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH $PATH:/root/.gvm/bin/

SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

# Copy python,json and shell scripts
COPY html_json.js /usr/local/dataintegration/
COPY html_json.sh /usr/local/dataintegration/
COPY .bash_profile /
COPY wrapper.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/html_json.js
RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh



FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH $PATH:/root/.gvm/bin/

SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

# Copy python,json and shell scripts
COPY html_json.sh /usr/local/dataintegration/
#
#
COPY wrapper.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh



FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH $PATH:/root/.gvm/bin/

SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

# Copy python,json and shell scripts
COPY html_json.js /usr/local/dataintegration/
COPY html_json.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/wrapper.sh

RUN chmod +x /usr/local/dataintegration/html_json.js
RUN chmod +x /usr/local/dataintegration/html_json.sh



FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g xml2json-command

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH $PATH:/root/.gvm/bin/

SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

# Copy python,json and shell scripts
COPY html_json.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh


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



FROM ubuntu:16.04

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

COPY html_json.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh



FROM ubuntu:16.04

ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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
COPY keys.json /usr/local/dataintegration/
COPY html_json.sh /usr/local/dataintegration/
COPY Download_html.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/Download_html.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh



FROM phusion/baseimage:0.11

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install python pip
RUN  apt-get update &&  apt-get install -y python  && \
     apt-get install -y python-pip && \
     apt-get install -y git && \
     apt-get install -y wget && \
     apt-get install -y jq

# Install boto( will also install botocore) and awscli
RUN python --version && \
     pip install boto3 && \
     pip install awscli && \
     pip install athena-cli

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

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH $PATH:/root/.gvm/bin/

SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

CMD ["/sbin/my_init", "/bin/bash"]

# Copy python,json and shell scripts
COPY html_json.js /usr/local/dataintegration/
COPY html_json.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/
COPY .bash_profile /

RUN chmod +x /usr/local/dataintegration/wrapper.sh

RUN chmod +x /usr/local/dataintegration/html_json.js
RUN chmod +x /usr/local/dataintegration/html_json.sh



FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

#ENV PATH $PATH:/root/.gvm/bin/

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH $PATH:/root/.gvm/bin/

SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

COPY html_json.sh /usr/local/dataintegration/
COPY html_json.js /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/html_json.js
RUN chmod +x /usr/local/dataintegration/wrapper.sh



FROM ubuntu:16.04

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


COPY html_json.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh



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
     pip install awscli


# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME


CMD ["/sbin/my_init", "/bin/bash"]

COPY StringSearch-1.0-SNAPSHOT.jar /usr/local/dataintegration/
COPY stringsearch.sh /usr/local/dataintegration/


RUN chmod +x /usr/local/dataintegration/stringsearch.sh
FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install python pip
RUN  apt-get update &&  apt-get install -y python  && \
     apt-get install -y python-pip && \
     apt-get install -y git && \
     apt-get install -y wget && \
     apt-get install -y jq && \
     apt-get install -y unzip

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

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Copy python,json and shell scripts
ADD  etl /usr/local/dataintegration/etl
WORKDIR /usr/local/dataintegration/etl
RUN npm install

COPY xml_json.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/etl/xml_json.js
RUN chmod +x /usr/local/dataintegration/xml_json.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh


FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install python pip
RUN  apt-get update &&  apt-get install -y --no-install-recommends python \
      python-setuptools python-dev build-essential python-pip   \
      git  \
      wget  \
      jq

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
                        build-essential --no-install-recommends && \
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/${GVM_VERSION}/binscripts/gvm-installer) && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH $PATH:/root/.gvm/bin/


SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go


COPY html_json.sh /usr/local/dataintegration/
COPY html_json.js /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/html_json.js
RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh
FROM ubuntu:16.04

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

# Copy python,json and shell scripts
COPY html_json.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh



FROM ubuntu:16.04


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
COPY wrapper.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh



FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

#ENV PATH $PATH:/root/.gvm/bin/

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH $PATH:/root/.gvm/bin/

SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

COPY html_json.sh /usr/local/dataintegration/
COPY html_json.js /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/
#
#
RUN chmod +x /usr/local/dataintegration/html_json.sh
RUN chmod +x /usr/local/dataintegration/html_json.js
RUN chmod +x /usr/local/dataintegration/wrapper.sh



FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Copy python,json and shell scripts
ADD  etl /usr/local/dataintegration/etl
WORKDIR /usr/local/dataintegration/etl
RUN npm install

COPY xml_json.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/etl/xml_json.js
RUN chmod +x /usr/local/dataintegration/xml_json.sh
RUN chmod +x /usr/local/dataintegration/wrapper.sh



FROM ubuntu:16.04

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.2.0
ENV GVM_VERSION=1.0.22

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH $PATH:/root/.gvm/bin/

SHELL ["/bin/bash", "-c", "source /root/.gvm/scripts/gvm &&  gvm install go1.9 --binary &&  gvm use go1.9 &&  go get -u -f github.com/ericchiang/pup"]

ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $PATH:/$HOME/go

# Copy python,json and shell scripts
COPY html_json.js /usr/local/dataintegration/
COPY html_json.sh /usr/local/dataintegration/
COPY wrapper.sh /usr/local/dataintegration/

RUN chmod +x /usr/local/dataintegration/wrapper.sh

RUN chmod +x /usr/local/dataintegration/html_json.js
RUN chmod +x /usr/local/dataintegration/html_json.sh



