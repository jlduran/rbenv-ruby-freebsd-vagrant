#!/bin/sh -e

# Create the vagrant user with a password of vagrant
pw groupadd vagrant -g 1010
mkdir -p /home/vagrant
pw useradd -n vagrant -u 1010 -c 'Vagrant User' -d /home/vagrant \
	-g 1010 -m -M 0755 -w yes -s /bin/sh
