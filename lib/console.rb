# encoding: utf-8
=begin
Run with:
pry -r ./console.rb

Based on simple_test.rb
https://github.com/appium/appium/blob/82995f47408530c80c3376f4e07a1f649d96ba22/sample-code/examples/ruby/simple_test.rb
https://github.com/appium/appium/blob/c58eeb66f2d6fa3b9a89d188a2e657cca7cb300f/LICENSE
=end

require 'selenium-webdriver'

# ruby_console files
require 'helper'
require 'button'
require 'textfield'
require 'secure' # secure textfield
require 'text'
require 'window'
require 'patch'
require 'alert'

# Path to the .app or .app.zip.
# The path can be local or remote for Sauce.
APP_PATH = ENV['APP_PATH'] unless defined?(APP_PATH)
# Sauce Username
SAUCE_USERNAME = ENV['SAUCE_USERNAME']
# Sauce Key
SAUCE_ACCESS_KEY = ENV['SAUCE_ACCESS_KEY']

# WebDriver capabilities. Must be valid for Sauce to work.
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

# Converts environment variable APP_PATH to an absolute path.
# @return [String] APP_PATH as an absolute path
def absolute_app_path
    raise 'APP_PATH environment variable not set!' if APP_PATH.nil?
    return APP_PATH if APP_PATH.match(/^http/) # public URL for Sauce
    return APP_PATH if APP_PATH.match(/^\//) # absolute file path
    file = File.join(File.dirname(__FILE__), APP_PATH)
    raise "App doesn't exist #{file}" unless File.exist? file
    file
end

# Get the server url for sauce or local based on env vars.
# @return [String] the server url
def server_url
  if !SAUCE_USERNAME.nil? && !SAUCE_ACCESS_KEY.nil?
    "http://#{SAUCE_USERNAME}:#{SAUCE_ACCESS_KEY}@ondemand.saucelabs.com:80/wd/hub"
  else
    'http://127.0.0.1:4723/wd/hub'
  end
end

# Quits the driver
# @return [void]
def driver_quit
  # rescue NoSuchDriverError
  begin; $driver.quit unless $driver.nil?; rescue; end
end

# Creates a new global driver and quits the old one if it exists.
# @return [Selenium::WebDriver] the new global driver
def start_driver
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

  $driver
end

# Setup driver
start_driver if $driver.nil?

# The same as $driver.execute_script
# @return the object returned by execute_script
def execute_script script, *args
  $driver.execute_script script, *args
end

# Quit the driver and Pry.
# quit and exit are reserved by Pry.
def x
  driver_quit
  exit # exit pry
end

# Paging in Pry is annoying :q required to exit.
# With pager disabled, the output is similar to IRB
# Only set if Pry is defined.
Pry.config.pager = false if defined?(Pry)
