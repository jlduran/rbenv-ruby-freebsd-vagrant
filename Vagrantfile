versions = { freebsd: '12.0', ruby: '2.6.0-rc1' }

Vagrant.configure(2) do |config|
  config.vm.box = "freebsd/FreeBSD-#{versions[:freebsd]}-RELEASE"
  config.vm.hostname = "freebsd-#{versions[:freebsd]}"
  config.vm.network 'private_network', type: 'dhcp'
  config.vm.synced_folder '.', '/vagrant', type: 'nfs'
  config.vm.provider :virtualbox do |v|
    v.default_nic_type = 'virtio'
  end

  config.ssh.shell = 'sh'

  config.vm.provision 'shell', inline: <<-ROOT
    freebsd-update fetch install --not-running-from-cron

    # Use the latest package repository
    mkdir -p /usr/local/etc/pkg/repos
    echo 'FreeBSD: { url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest" }' > \
      /usr/local/etc/pkg/repos/FreeBSD.conf

    # Upgrade and install required packages
    pkg upgrade -y
    pkg install -y bash git-lite gmp libedit libffi libunwind libyaml rbenv ruby-build

    # Prepare the vagrant user:
    # Change its default shell to Bash
    pw usermod vagrant -s /usr/local/bin/bash
  ROOT

  config.vm.provision 'shell', privileged: false, inline: <<-VAGRANT
    # Initialize rbenv
    printf 'export RBENV_NATIVE_EXT=1\neval "$(rbenv init -)"\n' > \
      /home/vagrant/.bash_profile

    # Install Ruby as the vagrant user
    RUBY_CONFIGURE_OPTS=--disable-install-doc \
      rbenv install "#{versions[:ruby]}"
    rbenv global "#{versions[:ruby]}"

    # Disable gems' documentation
    echo 'gem: --no-document' > /home/vagrant/.gemrc
  VAGRANT
end
