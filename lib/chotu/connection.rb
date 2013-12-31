require 'socket'
require 'http/parser'
require_relative 'request_processor'

module Chotu
  class Connection
    def initialize(port_num)
      @server = TCPServer.new port_num
    end

    def start(app)
      loop do
        Thread.start(@server.accept) do |socket|
          RequestProcessor.new(socket, app).process
        end
      end
      rescue Interrupt
        puts 'Chai too hot. Killed.'
    end
  end
end
