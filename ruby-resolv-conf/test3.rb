require 'resolv'

p Resolv::DNS::Config.parse_resolv_conf('resolv.conf')
