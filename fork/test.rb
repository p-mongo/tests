require 'mongo'

Mongo::Logger.logger.level = :warn

logging_client = Mongo::Client.new(['127.0.0.1:14420'], database: 'log')

logging_client['log'].delete_many

processes = []

5.times do |i|
  rd, wr = IO.pipe
  if pid = fork
    puts "Forked child #{pid}"
    wr.close
    processes << {
      pid: pid,
      pipe: rd,
    }
  else
    # In child
    rd.close
    child_client = Mongo::Client.new(['127.0.0.1:14420'], database: 'log')
    5.times do
      num_entries = child_client['log'].count_documents({})
      wr.puts(num_entries)
      sleep 1
    end
    exit
  end
end

5.times do
  processes.each do |process|
    entries = process[:pipe].readline.to_i
    puts "Process #{process[:pid]} reports #{entries} entries"
    logging_client['log'].insert_one(pid: process[:pid], entries: entries)
  end
end

processes.each do |process|
  Process.wait(process[:pid])
end
