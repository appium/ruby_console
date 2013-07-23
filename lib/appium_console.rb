# encoding: utf-8
require 'rubygems'
Gem::Specification.class_eval { def self.warn( args ); end }
require 'pry'

module Appium; end unless defined? Appium

module Appium::Console
  require 'appium_lib'
  to_require = load_appium_txt file: Dir.pwd + '/appium.txt', verbose: true

  start = File.expand_path '../start.rb', __FILE__
  # to do:
  # -e switch to pass require string
  cmd = ['-r', start]

  if to_require && !to_require.empty?
    load_files = to_require.map { |f| %(require "#{f}";) }.join "\n"
    cmd += [ '-e', load_files ]
  end

  $stdout.puts "pry #{cmd.join(' ')}"
  Pry::CLI.parse_options cmd
end # module Appium::Console