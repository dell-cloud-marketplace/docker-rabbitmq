docker-rabbitmq
=====================

RabbitMQ is a complete and highly reliable enterprise messaging system based on the emerging AMQP standard.

## Components

The stack comprises the following components:

Name            | Version                   | Description
----------------|---------------------------|------------------------------
RabbitMQ Server | 3.4.1                     | Enterprise messaging system
Ubuntu          | Trusty                    | Operating system

## Usage

### Start the Container

#### A. Basic Usage

Start your container with:

* Ports 5672 and 15672 exposed (RabbitMQ ports)
* A named container (**rabbitmq**)

As follows: 

Run the following command to start rabbitmq:

	sudo docker run -d -p 5672:5672 -p 15672:15672 --name rabbitmq dell/rabbitmq

The first time that you run your container, a new random password will be set for the Rabbit administrator user **admin**.
To get the password, check the logs of the container by running:

	docker logs rabbitmq

You will see an output like the following:

	========================================================================
	You can now connect to this RabbitMQ server using, for example:

            curl --user admin:5elsT6KtjrqV  http://<host>:<port>/api/vhosts

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `5elsT6KtjrqV` is the password set. 
You can then connect to RabbitMQ:

        curl --user admin:5elsT6KtjrqV http://localhost:5672/api/vhosts

Done!

#### B. Advanced Usage

Start your container with:

* Ports 5672 and 15672 exposed (RabbitMQ ports)
* A named container (**rabbitmq**)
* A predefined password for the RabbitMQ **admin** user by setting the environment variable `RABBITMQ_PASS`
* Two volumes (which will survive a restart or recreation of the container). The RabbitMQ directory is available in **/var/lib/rabbitmq** on the host. The logs files are available in **/var/log/rabbitmq** on the host.

	sudo docker run -d -p 5672:5672 \
		-p 15672:15672 \
		-e RABBITMQ_PASS="mypass" \
		-v /var/log/rabbitmq:/var/log/rabbitmq \
		-v /var/lib/rabbitmq:/var/lib/rabbitmq \
		--name rabbitmq dell/rabbitmq

You can now test your new RabbitMQ admin password:

        curl --user admin:mypass http://localhost:5672/api/vhosts

## Reference

### Image Details

Inspired by [tutumcloud/tutum-docker-rabbitmq](https://github.com/tutumcloud/tutum-docker-rabbitmq)

Pre-built Image | [https://registry.hub.docker.com/u/dell/rabbitmq](https://registry.hub.docker.com/u/dell/rabbitmq) 
