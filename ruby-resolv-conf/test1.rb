require 'resolv'

File.open('test1.conf', 'w') do |f|
  f.puts "search test"
end

p Resolv::DNS::Config.parse_resolv_conf('test1.conf')
