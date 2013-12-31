require_relative 'http_codes'

class RequestProcessor
  def initialize(socket, app)
    @socket = socket
    @parser = Http::Parser.new self
    @app = app
  end

  def process
    puts 'process'
    until @socket.closed? || @socket.eof?
      data = @socket.readpartial 1024
      @parser << data
    end
  end

  def on_message_complete
    puts 'on_message_complete'
    send_response
    close_socket
  end

  def send_response
    puts "SEND RESPONSE"
    env = parsed_data_to_env
    status, headers, body = @app.call env
    @socket.write "HTTP/#{@parser.http_version.join(".")} #{status} #{Chotu::HTTP_STATUS[status]}\r\n"

    headers.each_pair { |key, value| @socket.write "#{key}: #{value}\r\n" }
    @socket.write "\r\n"
    body.each { |piece| @socket.write piece }
    body.close if body.respond_to? :close
  end

  def parsed_data_to_env
    env = {}
    @parser.headers.each_pair do |key, value|
      env["HTTP_#{key.upcase.gsub('-', '_')}"] = value
    end
    env['PATH_INFO'] = @parser.request_url
    env['REQUEST_METHOD'] = @parser.http_method
    env['rack.input'] = StringIO.new
    puts env
    env
  end

  def close_socket
    @socket.close
  end
end
