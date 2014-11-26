#!/bin/bash

# Set RabbitMQ admin password
if [ ! -f /.rabbitmq_password_set ]; then
	/set_rabbitmq_password.sh
fi

# Make rabbitmq own its own files
chown -R rabbitmq:rabbitmq /var/lib/rabbitmq
chown -R rabbitmq:rabbitmq /var/log/rabbitmq

# Start RabbitMQ 
exec /usr/sbin/rabbitmq-server
