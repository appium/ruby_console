# encoding: utf-8
require 'rubygems'
require 'appium_lib'

if $driver.nil?
  opts = Pry.pry_load_appium_txt
  # override command timeout so the server doesn't shut down after 60 seconds
  new_command_timeout = { caps: { newCommandTimeout: 999_999 }.merge(opts[:caps] || {}) }
  opts = opts.merge(new_command_timeout)
  Appium::Driver.new(opts).start_driver
end

# Load minitest
begin
  require 'minitest'
  require 'minitest/spec'
  # set current_spec. fixes:
  # NoMethodError: undefined method `assert_equal' for nil:NilClass
  Minitest::Spec.new 'pry'
rescue
end

def reload
  Pry.reload
  nil
end