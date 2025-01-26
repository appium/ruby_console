# frozen_string_literal: true

require 'rubygems'
require 'appium_lib'

# must prefix pry commands such as %reset or the pry command will
# override the ruby_lib command with the same name.
#
# old Pry may not respond to config
Pry.respond_to?(:config) ? Pry.config.command_prefix = '%' : ''

opts = Pry.pry_load_appium_txt
# override command timeout so the server doesn't shut down after 60 seconds
new_command_timeout = { caps: { newCommandTimeout: 999_999 }.merge(opts[:caps] || {}) }
opts = opts.merge(new_command_timeout)
core = Appium::Driver.new opts, false
core.start_driver
Appium.promote_appium_methods Object, core

# Load minitest
begin
  require 'minitest'
  require 'minitest/spec'
  # set current_spec. fixes:
  # NoMethodError: undefined method `assert_equal' for nil:NilClass
  Minitest::Spec.new 'pry'
rescue StandardError => e
  puts(e.message)
end

def reload
  Pry.reload
  nil
end
