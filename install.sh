#!/bin/bash

apt-get update
apt-get install -y git gcc wget libpcre3 libpcre3-dev libssl-dev make build-essential zlib1g-dev libbz2-dev unzip

# Install Nginx with the Nginx upstream check module (https://github.com/yaoweibin/nginx_upstream_check_module) patched in
#   The configuration parameter error-log-path is set to standard error to keep the error log out of the conatainer.
#   Unlike the access log location, the error log location setting in the config file does not actually change the error log location
#   See https://stackoverflow.com/questions/13371925/how-to-turn-off-or-specify-the-nginx-error-log-location
cd /tmp
git clone https://github.com/yaoweibin/nginx_upstream_check_module.git
wget 'http://nginx.org/download/nginx-1.14.2.tar.gz'
tar -xzvf nginx-1.14.2.tar.gz
cd nginx-1.14.2
patch -p0 < ../nginx_upstream_check_module/check_1.14.0+.patch
./configure --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_degradation_module \
    --with-mail \
    --with-file-aio \
    --with-ipv6 \
    --add-module=../nginx_upstream_check_module \
    --prefix=/usr \
    --conf-path=/etc/nginx/nginx.conf \
    --user=nginx \
    --group=nginx \
    --error-log-path=/dev/stderr

make
make install
apt-get remove -y git gcc libssl-dev libpcre3-dev
apt-get clean

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -fr /tmp/*

mkdir /var/log/nginx
mkdir /etc/nginx/conf.d
rm -fr /etc/nginx/*.default
adduser --system --no-create-home --shell /bin/false --group --disabled-login nginx
