FROM ubuntu:16.04
LABEL authors="AndrewAI <yongchanlong@gmail.com>"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN apt-get update && \ 
	apt-get install -y python3 wget bzip2 libfontconfig && \
	apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/plugins/
RUN wget "https://bootstrap.pypa.io/get-pip.py" && \
	python3 get-pip.py && \
	pip3 install selenium PyMySQL
RUN wget "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" && \
	tar xjf phantomjs-2.1.1-linux-x86_64.tar.bz2
ENV PATH=$PATH:/usr/src/plugins/phantomjs-2.1.1-linux-x86_64/bin
WORKDIR /usr/src/app
# About selenium browser download: 
# http://www.seleniumhq.org/download/ 
# About ubuntu install selenium + phantomjs:
# http://withr.me/set-up-selenium-headless-on-ubuntu-16.04/
# About phantomjs tutorial:
# https://www.jianshu.com/p/9d408e21dc3a
