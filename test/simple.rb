# frozen_string_literal: true

# run with
# ruby my_test.rb
#
# Example use of running a test standalone. Useful for debugging a single test.

require 'rubygems'
require 'appium_lib'

def sign_in(driver)
  driver.button('Sign In').click
end

driver = Appium::Driver.new(Appium.load_appium_txt(file: 'appium.txt'), false)
begin
  driver.start_driver
  sign_in(driver)
ensure
  driver.driver_quit
end
