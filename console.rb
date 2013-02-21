# encoding: utf-8
=begin
Run with:
pry -I . -r console.rb

Based on simple_test.rb
https://github.com/appium/appium/blob/82995f47408530c80c3376f4e07a1f649d96ba22/sample-code/examples/ruby/simple_test.rb
https://github.com/appium/appium/blob/c58eeb66f2d6fa3b9a89d188a2e657cca7cb300f/LICENSE
=end

require 'rspec'
require 'selenium-webdriver'

# __FILE__ = path to this file
$:.unshift File.expand_path('../lib', __FILE__)

# ruby_console files
require 'helper'
require 'button'
require 'textfield'
require 'secure_textfield'
require 'text'
require 'window'
require 'patch'
require 'alert'

APP_PATH = ENV['APP_PATH'] unless defined?(APP_PATH)

def capabilities
  {
    browserName: 'iOS 6.0',
    platform: 'Mac 10.8',
    version: '6.0',
    device: 'iPhone Simulator',
    name: ENV['APP_NAME'] || 'Ruby Console iOS Appium',
    app: absolute_app_path
  }
end

def absolute_app_path
    # TODO: Support absolute APP_PATH
    raise 'APP_PATH environment variable not set!' if APP_PATH.nil?
    return APP_PATH if APP_PATH.match(/^http/) # public URL for Sauce
    return APP_PATH if APP_PATH.match(/^\//) # absolute file path
    file = File.join(File.dirname(__FILE__), APP_PATH)
    raise "App doesn't exist #{file}" unless File.exist? file
    file
end

def server_url
  if !ENV['SAUCE_USERNAME'].nil? && !ENV['SAUCE_ACCESS_KEY'].nil?
    "http://#{SAUCE_USERNAME}:#{SAUCE_ACCESS_KEY}@ondemand.saucelabs.com:80/wd/hub"
  else
    'http://127.0.0.1:4723/wd/hub'
  end
end

def driver_quit
  # rescue NoSuchDriverError
  begin; $driver.quit unless $driver.nil?; rescue; end
end

def driver
  @client = @client || Selenium::WebDriver::Remote::Http::Default.new
  @client.timeout = 999999
  
  # If the driver already exists, quit before creating a new driver.
  driver_quit
  
  $driver = Selenium::WebDriver.for(:remote, http_client: @client, desired_capabilities: capabilities, url: server_url)

  # Set timeout to a large number so that Appium doesn't quit
  # when no commands are entered after 60 seconds.
  $driver.execute_script 'mobile: setCommandTimeout', timeout: 9999

  # Must set implicit_wait to zero or $ commands will fail.
  # execute_script "$('button')"
  $driver.manage.timeouts.implicit_wait = 0
end

# Setup driver
driver if $driver.nil?

# execute_script helper method.
def execute_script script, *args
  $driver.execute_script script, *args
end

# Define x to close driver and Pry.
# quit and exit are reserved by Pry.
def x
  driver_quit
  exit # exit pry
end

# Paging in Pry is annoying :q required to exit.
# With pager disabled, the output is similar to IRB
# Only set if Pry is defined.
Pry.config.pager = false if defined?(Pry)
