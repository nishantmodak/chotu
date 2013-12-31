require 'optparse'

module Chotu
  # Class for Command Line Invocation
  class Runner
    def initialize(argv)
      @argv = argv
      @pwd  = Dir.pwd
      @port = 4321
      @rackup_app_file = nil
    end

    def run
      Dir.chdir(@pwd)
      parser.parse! @argv
      rackup_app = @pwd + '/' + @rackup_app_file
      Chotu::Server.start(rackup_app, @port)
    end

    def parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = 'chotu [options]'
        opts.on('-p', '--port PORT', 'use PORT (default: 4321)') do |port|
          @port = port.to_i
        end
        opts.on('-r', '--rack RACKUP', 'default: config.ru') do |rack_file|
          @rackup_app_file = rack_file
        end
        @rackup_app_file = 'config.ru' if @rackup_app_file.nil?
      end
    end
  end
end
