require 'resolv'

File.open('test2.conf', 'w') do |f|
  f.puts "domain test"
  f.puts "#search test"
end

p Resolv::DNS::Config.parse_resolv_conf('test2.conf')
