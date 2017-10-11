FROM ubuntu:16.04

RUN apt-get update &&\
  apt-get -y install wget &&\
  apt-get -y install gettext-base &&\
  wget -qO - https://openresty.org/package/pubkey.gpg | apt-key add - &&\
  apt-get -y install software-properties-common &&\
  add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" &&\
  apt-get update &&\
  apt-get -y install openresty &&\
  apt-get clean

COPY nginx.template /nginx.template

CMD  /bin/bash -c "export D='$' && envsubst < /nginx.template > /etc/openresty/nginx.conf && openresty -g 'daemon off;'"
