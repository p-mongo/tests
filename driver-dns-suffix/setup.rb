#!/usr/bin/env ruby

require 'byebug'
require_relative './child_process_helper'
require 'mongo'

HOST = 'rstest'

=begin
ChildProcessHelper.check_call(%w(
  mlaunch init --dir /mnt/zram/mongodb/repro.dns-suffix --replicaset))
=end

client = Mongo::Client.new(['localhost:27017'])

cfg = client.database.command(replSetGetConfig:1).reply.documents.first['config']

cfg['version'] += 1
cfg['members'].each do |member|
  port = member['host'].sub(/.*:/, '')
  member['host'] = "#{HOST}:#{port}"
end

p client.database.command(replSetReconfig: cfg)

byebug
1
