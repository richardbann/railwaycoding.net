FROM ubuntu:artful-20171019

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y python3 python3-pip

RUN pip3 install pelican==3.7.1

RUN apt-get install -y nginx
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf
