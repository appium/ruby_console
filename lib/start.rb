# encoding: utf-8
require 'rubygems'
require 'appium_lib'

Appium::Driver.new(export_session: true).start_driver if $driver.nil?

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