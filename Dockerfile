FROM ubuntu

COPY ./install.sh /tmp/install.sh
RUN /tmp/install.sh
COPY ./nginx.conf /etc/nginx/nginx.conf

ENV NGINX_VERSION 1.9.15

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
EXPOSE 443

