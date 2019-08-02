#\ -s puma
require './app'
run Sinatra::Application

# puma -t 0:5 -w 100 config.puma.ru
