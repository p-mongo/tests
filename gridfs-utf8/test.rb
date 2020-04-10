require 'mongo'

client = Mongo::Client.new(['localhost:14420'], database: 'test')

grid = client.database.fs

file_name = 'test_fern.txt'
grid.open_upload_stream(file_name) do |stream|
stream.write('Fèrn')
end

grid.open_download_stream_by_name(file_name) do |stream|
puts stream.read
end
