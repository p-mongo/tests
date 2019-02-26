#!/usr/bin/env ruby

$: << File.dirname(__FILE__)

require 'byebug'
require 'mongo'
require 'cluster_tools'

class Status
  def client
    @client ||= Mongo::Client.new(['127.0.0.1:27741'], heartbeat_frequency: 1)
  end

  def direct_client(address)
    @direct_clients ||= {}
    @direct_clients[address] ||= Mongo::Client.new([address.to_s], connect: :direct)
  end

  def direct_admin_client(address)
    @direct_admin_clients ||= {}
    @direct_admin_clients[address] ||= Mongo::Client.new([address.to_s], connect: :direct, database: 'admin')
  end

  def start_monitor
    Thread.new do
      loop do
        puts "--- #{Time.now}"
        client.cluster.servers_list.each do |server|
          puts server.summary
          result = direct_admin_client(server.address).database.command(replSetGetStatus: 1)
          status = result.reply.payload['reply']
          this_status = status['members'].detect do |m|
            m['name'] == server.address.to_s
          end
          puts "#{server.address}: #{status['myState']} #{this_status['infoMessage']}"
          #byebug
          #1
        end
        sleep 1
      end
    end
  end

  def run
    start_monitor
    loop do
      sleep 10
    end
  end
end

Mongo::Logger.level = Logger::INFO
Status.new.run
