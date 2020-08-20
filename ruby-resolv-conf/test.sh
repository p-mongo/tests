#!/bin/sh

ping -c 1 gw.here

ping -c 1 gw

ruby -rresolv -e 'p Resolv::DNS::Config.default_config_hash'
