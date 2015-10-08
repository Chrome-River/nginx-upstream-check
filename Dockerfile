FROM dockerfile/ubuntu
COPY ./install.sh /tmp/install.sh
RUN /tmp/install.sh

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

EXPOSE 80
EXPOSE 443

