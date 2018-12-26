versions = { freebsd: '12.0', ruby: '2.6.0' }

Vagrant.configure(2) do |config|
  config.vm.box = "freebsd/FreeBSD-#{versions[:freebsd]}-RELEASE"
  config.vm.hostname = "freebsd-#{versions[:freebsd]}"
  config.vm.network 'private_network', type: 'dhcp'
  config.vm.synced_folder '.', '/vagrant', type: 'nfs'
  config.vm.provider :virtualbox do |v|
    v.default_nic_type = 'virtio'
  end

  config.ssh.shell = 'sh'

  config.vm.provision 'shell', path: './scripts/su.sh'

  config.vm.provision 'shell', privileged: false,
                               path: './scripts/user.sh',
                               args: versions[:ruby].to_s
end
