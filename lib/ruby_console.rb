require 'rubygems'
require 'pry'
require 'app_lib'

start = File.expand_path "../start.rb", __FILE__
cmd = ['-r', start]
$stdout.puts 'pry ' + cmd.join(' ')
Pry::CLI.parse_options cmd