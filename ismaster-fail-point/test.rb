require 'mongo'

Mongo::Logger.logger.level = :warn

def test(uri)
  client = Mongo::Client.new(uri)

  client.use('admin').database.command(
            configureFailPoint: 'failCommand',
            mode: {times: 1},
            data: {
              failCommands: %w(ismaster),
              closeConnection: true,
            },
  )

  llc_hit = begin
    client.database.command(ismaster: 1)
    false
  rescue Mongo::Error
    true
  end

  client.use('admin').database.command(
            configureFailPoint: 'failCommand',
            mode: {times: 1},
            data: {
              failCommands: %w(ismaster),
              closeConnection: true,
            },
  )

  luc_hit = begin
    client.database.command(isMaster: 1)
    false
  rescue Mongo::Error
    true
  end

  client.use('admin').database.command(
    configureFailPoint: 'failCommand', mode: 'off'
  )

  client.use('admin').database.command(
            configureFailPoint: 'failCommand',
            mode: {times: 1},
            data: {
              failCommands: %w(isMaster),
              closeConnection: true,
            },
  )

  ulc_hit = begin
    client.database.command(ismaster: 1)
    false
  rescue Mongo::Error
    true
  end

  client.use('admin').database.command(
            configureFailPoint: 'failCommand',
            mode: {times: 1},
            data: {
              failCommands: %w(isMaster),
              closeConnection: true,
            },
  )

  uuc_hit = begin
    client.database.command(isMaster: 1)
    false
  rescue Mongo::Error
    true
  end

  client.use('admin').database.command(
    configureFailPoint: 'failCommand', mode: 'off'
  )

  client.close

  puts "#{uri} ismaster/ismaster: #{llc_hit} ismaster/isMaster: #{luc_hit}"
  puts "#{uri} isMaster/ismaster: #{luc_hit} isMaster/isMaster: #{uuc_hit}"
end

%w(
  mongodb://localhost:14420
  mongodb://localhost:14440
).each do |uri|
  test(uri)
end
