FROM ubuntu
COPY ./install.sh /tmp/install.sh
RUN /tmp/install.sh
COPY ./nginx.conf /etc/nginx/nginx.conf

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

EXPOSE 80
EXPOSE 443

