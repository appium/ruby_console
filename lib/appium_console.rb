# encoding: utf-8
require 'rubygems'
Gem::Specification.class_eval { def self.warn( args ); end }
require 'pry'

module Appium; end unless defined? Appium

module Appium::Console
  # Check for env vars in .txt
  toml = File.join Dir.pwd, 'appium.txt'

  class Env
    def initialize data
      @data = data
    end

    def update *args
      args.each do |name|
        var = @data[name]
        ENV[name] = var if var
      end
    end
  end

  if File.exists? toml
    require 'toml'
    require 'ap'
    puts "Loading #{toml}"

    # bash requires A="OK"
    # toml requires A = "OK"
    #
    # A="OK" => A = "OK"
    data = File.read(toml).gsub /([^\s])\=(")/, "\\1 = \\2"
    data = TOML::Parser.new(data).parsed
    ap data

    env = Env.new data
    env.update 'APP_PATH', 'APP_APK', 'APP_PACKAGE',
               'APP_ACTIVITY', 'APP_WAIT_ACTIVITY',
               'SELENDROID'

    # Ensure app path is absolute
    ENV['APP_PATH'] = File.expand_path ENV['APP_PATH'] if ENV['APP_PATH']
  end

  require 'appium_lib'

  start = File.expand_path '../start.rb', __FILE__
  cmd = ['-r', start]
  $stdout.puts "pry #{cmd.join(' ')}"
  Pry::CLI.parse_options cmd
end # module Appium::Console