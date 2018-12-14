#!/bin/sh -e

# Initialize rbenv
# shellcheck disable=SC2016
printf 'export RBENV_NATIVE_EXT=1\neval "$(rbenv init -)"\n' > \
	/home/vagrant/.bash_profile

# Install Ruby as the vagrant user
RUBY_CONFIGURE_OPTS=--disable-install-doc rbenv install "$1"
rbenv global "$1"

# Disable gems' documentation
echo 'gem: --no-document' > /home/vagrant/.gemrc
