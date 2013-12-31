require_relative 'app_loader'

module Chotu
  class Server
    include Loader::AppLoader

    def initialize(rackup_app_path, port)
      puts "rackup_app_path" + rackup_app_path
      @connection = Chotu::Connection.new port
      @app = load_app(rackup_app_path)
      puts "Chotu warming up at #{port}"
    end

    def self.start(rackup_app_path, port)
      new(rackup_app_path, port).start
    end

    def start
      puts 'Chotu ready to serve chai'
      @connection.start(@app)
    end
  end
end
