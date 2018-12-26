#!/bin/sh -e

# Initialize rbenv
cat > /home/vagrant/.bash_profile << END
export RBENV_NATIVE_EXT=1
eval "$(rbenv init -)"
END

# Install Ruby as the vagrant user
RUBY_CONFIGURE_OPTS="--disable-install-doc --with-opt-dir=/usr/local" \
	rbenv install "$1"
rbenv global "$1"

# Disable gems' documentation
echo 'gem: --no-document' > /home/vagrant/.gemrc
