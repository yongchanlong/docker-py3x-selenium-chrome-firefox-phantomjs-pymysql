FROM phusion/baseimage:0.10.0
LABEL authors="AndrewAI <yongchanlong@gmail.com>"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN apt-get update && \ 
	apt-get install -y python3 wget bzip2 libfontconfig xvfb firefox zip && \
	apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/plugins/
RUN wget "https://bootstrap.pypa.io/get-pip.py" && \
	python3 get-pip.py && \
	pip3 install selenium PyMySQL pyvirtualdisplay
	
# Install phantomjs
RUN wget "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" && \
	tar xjf phantomjs-2.1.1-linux-x86_64.tar.bz2
ENV PATH=$PATH:/usr/src/plugins/phantomjs-2.1.1-linux-x86_64/bin

# Install firefox
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz && \
	tar -zxvf geckodriver-v0.11.1-linux64.tar.gz && \
	mv geckodriver /usr/bin/
	
# Install chrome
RUN wget http://chromedriver.storage.googleapis.com/2.33/chromedriver_linux64.zip && \
	unzip chromedriver_linux64.zip && \
	mv chromedriver /usr/bin/
ENV PATH=$PATH:/usr/bin/

RUN apt-get update && \ 
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb  && \ 
	dpkg -i google-chrome-stable_current_amd64.deb; exit 0
RUN apt-get -f -y install && \ 
	dpkg -i google-chrome-stable_current_amd64.deb && \ 
	apt-get clean && rm -rf /var/lib/apt/lists/*
	
WORKDIR /usr/src/app
# About selenium browser download: 
# http://www.seleniumhq.org/download/ 
# About ubuntu install selenium + phantomjs:
# http://withr.me/set-up-selenium-headless-on-ubuntu-16.04/
# About phantomjs tutorial:
# https://www.jianshu.com/p/9d408e21dc3a
# if use chrome, than:
# chrome_options = webdriver.ChromeOptions()
# chrome_options.add_argument('--no-sandbox')
#  browser = webdriver.Chrome(chrome_options=chrome_options)
