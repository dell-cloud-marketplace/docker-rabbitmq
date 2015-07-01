# docker-rabbitmq

This image installs [RabbitMQ](http://www.rabbitmq.com/), a reliable enterprise messaging system based on the emerging AMQP standard.

## Components

The stack comprises the following components:

Name            | Version | Description
----------------|---------|------------------------------
RabbitMQ Server | latest  | Enterprise messaging system
Ubuntu          | Trusty  | Operating system

## Usage

### Start the Container

#### A. Basic Usage

Start your container with:

* A named container (**rabbitmq**)
* Ports 5672 (AMQP) and 15672 (web-based Management Console) exposed

As follows: 

```no-highlight
sudo docker run -d -p 5672:5672 -p 15672:15672 --name rabbitmq dell/rabbitmq
```
To get the password, check the logs of the container by running:

```no-highlight
docker logs rabbitmq
```

You will see output like the following:

```no-highlight
========================================================================
You can now connect to this RabbitMQ server using, for example:

    curl --user admin:5elsT6KtjrqV  http://<host>:<port>/api/vhosts

Please remember to change the above password as soon as possible!
========================================================================
```

In this case, `5elsT6KtjrqV` is the admin password. 

##### Management Console
The RabbitMQ management console can be accessed on the specified Management Console port (default 15672). Enter the user credentials retrieved from the container logs.

```no-highlight
http://127.0.0.1:15672     
```

#### B. Advanced Usage

Start your container with:

* A named container (**rabbitmq**)
* Ports 5672 and 15672 exposed
* A predefined username for the RabbitMQ admin user (via variable `RABBITMQ_USER`)
* A predefined password for admin user (via variable `RABBITMQ_PASS`)
* Two volumes (which will survive a restart or recreation of the container). The RabbitMQ directory is available in **/var/lib/rabbitmq** on the host. The logs files are available in **/var/log/rabbitmq** on the host.

```no-highlight
sudo docker run -d -p 5672:5672 \
     -p 15672:15672 \
     -e RABBITMQ_USER="rabbitmq_user" \
     -e RABBITMQ_PASS="rabbitmq_pass" \
     -v /var/log/rabbitmq:/var/log/rabbitmq \
     -v /var/lib/rabbitmq:/var/lib/rabbitmq \
     --name rabbitmq dell/rabbitmq
```

You can now test your container using the Management Console and the specified login credentials.

### A Simple Python Client
Firstly, please install **pika**:

```no-highlight
sudo pip install pika
```

Next, create file **send.py**, substuting the values for the user, password, and AMQP port (default 5672):

```python
import pika

credentials = pika.PlainCredentials('rabbitmq_user', 'rabbitmq_pass')
parameters = pika.ConnectionParameters('localhost',
                                       5672,
                                       '/',
                                       credentials)

connection = pika.BlockingConnection(parameters)
channel = connection.channel()

channel.queue_declare(queue='hello')

channel.basic_publish(exchange='',
                      routing_key='hello',
                      body='Hello World!')
print " [x] Sent 'Hello World!'"
connection.close()
```

Run the program, as follows:

```no-highlight
python send.py
```

You should then be able to see the new message via the Management Console.

For more details on sending and receiving messages through RabbitMQ, please refer to the RabbitMQ starting [guide](http://www.rabbitmq.com/getstarted.html).

## Reference

### Environmental Variables

Variable      | Default  | Description
--------------|----------|-----------------------------
RABBITMQ_USER | admin    | Name of the default user
RABBITMQ_PASS | *random* | Password of the default user

### Image Details

Based on [tutumcloud/tutum-docker-rabbitmq](https://github.com/tutumcloud/tutum-docker-rabbitmq)

Pre-built Image | [https://registry.hub.docker.com/u/dell/rabbitmq](https://registry.hub.docker.com/u/dell/rabbitmq) 
