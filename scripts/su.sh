#!/bin/sh -e

freebsd-update fetch install --not-running-from-cron

# Use the latest package repository
mkdir -p /usr/local/etc/pkg/repos
cat > /usr/local/etc/pkg/repos/FreeBSD.conf << END
FreeBSD: {
  url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest"
}
END

# Upgrade and install required packages
pkg upgrade -y
pkg install -y bash git-lite gmp libedit libffi libunwind libyaml rbenv \
	ruby-build

# Change vagrant's default shell to Bash
pw usermod vagrant -s /usr/local/bin/bash
