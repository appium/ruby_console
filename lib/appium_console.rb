# encoding: utf-8
require 'rubygems'
Gem::Specification.class_eval { def self.warn( args ); end }
require 'pry'

# Check for env vars in .txt
toml = File.join Dir.pwd, 'appium.txt'

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

  app_path = 'APP_PATH'
  app_package = 'APP_PACKAGE'
  app_activity = 'APP_ACTIVITY'
  app_wait_activity = 'APP_WAIT_ACTIVITY'

  path = data[app_path]
  pkg = data[app_package]
  act = data[app_activity]
  wait_act = data[app_wait_activity]

  ENV[app_path] = path if path
  ENV[app_package] = pkg if pkg
  ENV[app_activity] = act if act
  ENV[app_wait_activity] = wait_act if wait_act
end

require 'appium_lib'

start = File.expand_path "../start.rb", __FILE__
cmd = ['-r', start]
$stdout.puts 'pry ' + cmd.join(' ')
Pry::CLI.parse_options cmd