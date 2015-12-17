FROM node:4-slim

MAINTAINER Georgios Andrianakis geoand@gmail.com

#make bash the default shell
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV MMS_COMMUNITY_VERSION 1.9.2
ENV MMS_FILE_NAME_NO_ARCH mms-v$MMS_COMMUNITY_VERSION-community-linux.tar.gz

RUN curl -O http://packages.litixsoft.de/mms/$MMS_COMMUNITY_VERSION/mms-v$MMS_COMMUNITY_VERSION-community-linux.tar.gz
RUN tar -xf $MMS_FILE_NAME_NO_ARCH && tar -xf ${MMS_FILE_NAME_NO_ARCH/linux/linux-x86_64}
RUN MMS_FILE_NAME=${MMS_FILE_NAME_NO_ARCH/linux/linux-x86_64} && \
	tar -xf $MMS_FILE_NAME && \
	cd ${MMS_FILE_NAME/.tar.gz/} && \
	chmod +x install.sh && \
	./install.sh

#force node application to listen on all hosts
RUN sed -i s/127.0.0.1/0.0.0.0/g /opt/lx-mms/config.js

#cleanup 
RUN rm -rf mms-v*

EXPOSE 3333

VOLUME ["/root/.mms"]

CMD lx-mms

