task :test => :environment do


module Foobar

end



class BaseDoc

 include Mongoid::Document

 include Foobar



has_one :child, class_name: 'ChildDoc', inverse_of: :parent



field :data, type: String

end



class ChildDoc

 include Mongoid::Document

 include Foobar



belongs_to :parent, class_name: 'BaseDoc', inverse_of: :child, optional: true



field :data, type: String

end



base = BaseDoc.create(data: 'dog')

child = ChildDoc.create(data: 'cat')

child.parent = base

child.save



puts "Foobar === base is #{Foobar === base}"

puts "Foobar === child is #{Foobar === child}"



ref = base2 = ChildDoc.where(data: 'cat').first
byebug
ref.parent



puts "Foobar === base2 is #{Foobar === base2}"

puts "base2.is_a?(Foobar) is #{base2.is_a?(Foobar)}"



end


# frozen_string_literal: true
# encoding: utf-8

# Copyright (C) 2015-2020 MongoDB Inc.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

    class CommandLogSubscriber

      # @return [ Hash ] options The options.
      attr_reader :options

      # Constant for the max number of characters to print when inspecting
      # a query field.
      #
      # @since 2.1.0
      LOG_STRING_LIMIT = 250

      # Create the new log subscriber.
      #
      # @example Create the log subscriber.
      #   CommandLogSubscriber.new
      #
      # @param [ Hash ] options The options.
      #
      # @option options [ Logger ] :logger An optional custom logger.
      #
      # @since 2.1.0
      def initialize(options = {})
        @options = options
      end

      # Handle the command started event.
      #
      # @example Handle the event.
      #   subscriber.started(event)
      #
      # @param [ CommandStartedEvent ] event The event.
      #
      # @since 2.1.0
      def started(event)
          _prefix = prefix(event,
            connection_generation: event.connection_generation,
            connection_id: event.connection_id,
            server_connection_id: event.server_connection_id,
          )
          log_debug("#{_prefix} | STARTED | #{format_command(event.command)}")
      end

      # Handle the command succeeded event.
      #
      # @example Handle the event.
      #   subscriber.succeeded(event)
      #
      # @param [ CommandSucceededEvent ] event The event.
      #
      # @since 2.1.0
      def succeeded(event)
          log_debug("#{prefix(event)} | SUCCEEDED | #{'%.3f' % event.duration}s")
      end

      # Handle the command failed event.
      #
      # @example Handle the event.
      #   subscriber.failed(event)
      #
      # @param [ CommandFailedEvent ] event The event.
      #
      # @since 2.1.0
      def failed(event)
          log_debug("#{prefix(event)} | FAILED | #{event.message} | #{event.duration}s")
      end

      private

      def format_command(args)
        begin
          truncating? ? truncate(args) : args.inspect
        rescue Exception
          '<Unable to inspect arguments>'
        end
      end

      def prefix(event, connection_generation: nil, connection_id: nil,
        server_connection_id: nil
      )
        extra = [connection_generation, connection_id].compact.join(':')
        if extra == ''
          extra = nil
        else
          extra = "conn:#{extra}"
        end
        if server_connection_id
          extra += " sconn:#{server_connection_id}"
        end
        "#{event.address.to_s} req:#{event.request_id}#{extra && " #{extra}"} | " +
          "#{event.database_name}.#{event.command_name}"
      end

      def truncate(command)
        ((s = command.inspect).length > LOG_STRING_LIMIT) ? "#{s[0..LOG_STRING_LIMIT]}..." : s
      end

      def truncating?
        @truncating ||= (options[:truncate_logs] != false)
      end

      def log_debug(*args)
        STDERR.puts *args
      end
    end


task test_p: :environment do
  Band.collection.client.subscribe(Mongo::Monitoring::COMMAND, CommandLogSubscriber.new)
  p Band.create!(cat: Cat.new)
end

task ajqc: :environment do
  GuestsCleanupJob.perform_later
  sleep 1
end


task test_bd: :environment do
  class Foo
    include Mongoid::Document

    field :a
  end

  Foo.delete_all

  Foo.create!(a: 'zz')

  class Foo
    #field :a, type: Time
    field :a, type: BigDecimal
  end

  p Foo.first, Foo.first.a
end


task test_bw: :environment do
  a = Band.collection.client
  pp a['x'].insert_one({c:1}, write_concern:{w:0})
  pp a['x'].bulk_write([{insert_one:{a:1}}],write_concern:{w:0})

end

