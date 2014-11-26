FROM ubuntu:trusty
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>

# Set environment variable for package install
ENV DEBIAN_FRONTEND noninteractive

# Install and start RabbitMQ
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F7B8CEA6056E8E56 && \
    echo "deb http://www.rabbitmq.com/debian/ testing main" \
    >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y rabbitmq-server=3.4.2-1 pwgen && \
    service rabbitmq-server start && \
    rabbitmq-plugins enable rabbitmq_management && \
    service rabbitmq-server restart

# Add RabbitMQ startup scripts
ADD run.sh /run.sh
ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
RUN chmod 755 ./*.sh

# Expose logs and Mnesia volumes
VOLUME ["/var/log/rabbitmq","/var/lib/rabbitmq"]

# Expose RabbitMQ and RabbitMG management console ports
EXPOSE 5672 15672
CMD ["/run.sh"]
