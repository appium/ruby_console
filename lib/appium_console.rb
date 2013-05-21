# encoding: utf-8
require 'rubygems'
Gem::Specification.class_eval { def self.warn( args ); end }
require 'pry'

module Appium; end unless defined? Appium

module Appium::Console
  require 'appium_lib'
  load_appium_txt file: Dir.pwd + '/appium.txt'

  start = File.expand_path '../start.rb', __FILE__
  cmd = ['-r', start]
  $stdout.puts "pry #{cmd.join(' ')}"
  Pry::CLI.parse_options cmd
end # module Appium::Console