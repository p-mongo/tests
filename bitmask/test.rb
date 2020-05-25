require 'base64'

value = 0b00010100
packed = ''.force_encoding('binary')

while value > 0
  packed << (value % 256).chr
  value >>= 8
  p value
end

p packed

p Base64.encode64(packed)
