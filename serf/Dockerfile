FROM centos
MAINTAINER tmtk75

RUN yum install -y unzip curl
RUN curl -LO https://dl.bintray.com/mitchellh/serf/0.5.0_linux_386.zip
RUN unzip 0.5.0_linux_386.zip
RUN cp serf /usr/local/bin/

