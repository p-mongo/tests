#!/bin/sh

set -e

ifconfig lo:1 inet 127.2.0.1 netmask 255.255.255.255
ifconfig lo:2 inet 127.2.0.2 netmask 255.255.255.255
ifconfig lo:3 inet 127.2.0.3 netmask 255.255.255.255
ifconfig lo:4 inet 127.2.0.4 netmask 255.255.255.255
ifconfig lo:5 inet 127.2.0.5 netmask 255.255.255.255
ifconfig lo:6 inet 127.2.0.6 netmask 255.255.255.255

modprobe zram

mkdir -p /mnt/zram

if ! mount |grep -q /mnt/zram; then
  dev=`zramctl -f -s 1g`
  mkfs.xfs "$dev"
  mount -o noatime,nodiratime,nodev,nosuid "$dev" /mnt/zram
  mkdir /mnt/zram/sandbox
  chown sandbox:sandbox /mnt/zram/sandbox
fi
