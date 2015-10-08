#!/bin/bash

apt-get update
apt-get install -y git gcc wget libpcre3 libpcre3-dev libssl-dev make build-essential zlib1g-dev libbz2-dev unzip

#install nginx
cd /tmp
#git clone https://github.com/SirAnthony/ngx_ustats_module.git
git clone https://github.com/yaoweibin/nginx_upstream_check_module.git
wget 'http://nginx.org/download/nginx-1.9.5.tar.gz'
tar -xzvf nginx-1.9.5.tar.gz
cd nginx-1.9.5
patch -p0 < ../nginx_upstream_check_module/check_1.9.2+.patch
#patch -p1 -i  ../ngx_ustats_module/nginx-1.9+.patch
./configure --add-module=../nginx_upstream_check_module --with-http_ssl_module --prefix=/usr --conf-path=/etc/nginx/nginx.conf
make
make install
apt-get remove -y git gcc libssl-dev libpcre3-dev
apt-get clean

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -fr /tmp/*

mkdir /etc/nginx/conf.d
rm -fr /etc/nginx/*.default
