FROM ubuntu:trusty
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>

#Install RabbitMQ
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F7B8CEA6056E8E56 
RUN echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server=3.4.1-1 
RUN service rabbitmq-server start
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y pwgen
RUN rabbitmq-plugins enable rabbitmq_management
RUN service rabbitmq-server restart

# Add scripts
ADD run.sh /run.sh
ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
RUN chmod 755 ./*.sh

EXPOSE 5672 15672
CMD ["/run.sh"]
