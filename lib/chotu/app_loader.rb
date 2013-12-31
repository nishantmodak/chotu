class Loader
  module AppLoader
    def run app
      app
    end

    def load_app(config_file)
      puts "LOAD APP"
      eval File.read(config_file)
    end
  end
end
