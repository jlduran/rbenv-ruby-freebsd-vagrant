#!/bin/sh -e

freebsd-update fetch install --not-running-from-cron

# Use the latest package repository
mkdir -p /usr/local/etc/pkg/repos
# shellcheck disable=SC2016
echo 'FreeBSD: { url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest" }' > \
	/usr/local/etc/pkg/repos/FreeBSD.conf

# Upgrade and install required packages
pkg upgrade -y
pkg install -y bash git-lite gmp libedit libffi libunwind libyaml rbenv \
	ruby-build

# Change vagrant's default shell to Bash
pw usermod vagrant -s /usr/local/bin/bash
