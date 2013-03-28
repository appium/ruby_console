# encoding: utf-8
require 'rubygems'
Gem::Specification.class_eval { def self.warn( args ); end }
require 'pry'
require 'appium_lib'

start = File.expand_path "../start.rb", __FILE__
cmd = ['-r', start]
$stdout.puts 'pry ' + cmd.join(' ')
Pry::CLI.parse_options cmd
